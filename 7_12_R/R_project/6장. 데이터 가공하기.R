library(dplyr)
exam <- read.csv("data/csv_exam.csv")
exam
dim(exam)
summary(exam)
str(exam)

exam %>% filter(class == 1)

exam %>% filter(class == 2)

exam %>% filter(class != 1)

exam %>% filter(math >= 50)

#여러 조건을 충족하는 행 추출

exam %>% filter(class ==1, math >=50)

exam %>% filter(class != 2 | english >=60)

exam %>% filter(class == 1 | class == 3 | class == 4)

exam %>% filter(class %in% c(1,3,5))

class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)
mean(class1$math)
mean(class2$math)

# 혼자서 해보기
#q1.
mpg <- as.data.frame(ggplot2::mpg)
dim(mpg)
mpg_a <- mpg %>% filter(displ <=4)
mpg_b <- mpg %>% filter(displ >=5)
mean(mpg_a$hwy)
mean(mpg_b$hwy)

head(mpg)
#q2.
mpg_audi <- mpg %>% filter(manufacturer == 'audi')
mpg_toyota <- mpg %>% filter(manufacturer == 'toyota')
mean(mpg_audi$cty)
mean(mpg_toyota$cty)


#q3.
mpg_new <- mpg %>% filter(manufacturer %in% c('chevrolet','honda', 'ford'))
mean(mpg_new$hwy)

exam %>% select(class, english, math)

exam %>% select(-math, -english)

exam %>% filter(class == 1) %>% select(math, english)
exam %>% 
  filter(class != 1) %>% 
  select(-math, -english)

exam %>% 
  select(-math) %>% 
  head(10)
mpg <- as.data.frame(ggplot2::mpg)

df <- mpg %>% select(class, cty)
df
head(df)
df_suv <- df %>% filter(class == 'suv')
df_compact <- df %>% filter(class == 'compact')
mean(df_suv$cty)
mean(df_compact$cty)

exam %>% arrange(math)
exam %>% arrange(desc(math))
head(exam) %>% arrange(math)
exam %>% arrange(class, math)


# p.141 혼자 풀어보기
mpg <- as.data.frame(ggplot2::mpg)
dim(mpg)
head(mpg)
mpg_audi <- mpg %>% filter(manufacturer == 'audi')
mpg_audi %>% arrange(desc(hwy)) 
head(mpg_audi,5)s

# 6-5 파생변수 추가하기
exam %>% 
  mutate(total = math, english, science) %>% head

exam %>% 
  mutate(total = math + english + science,
         mean = (math + english + science)/3) %>%
  head

exam %>% 
  mutate(test = ifelse(science >= 60, 'pass','fail')) %>% head

# p.144 혼자서 해보기

mpg <- as.data.frame(ggplot2::mpg)
df_mpg <- mpg
df_mpg %>% 
  mutate(total = cty + hwy) %>% 
  arrange(desc(total)) %>% 
  head(3)
summary(df_mpg)

df_mpg %>% 
  mutate(total_mean = (cty + hwy)/2,
         total = cty + hwy) %>% 
  arrange(desc(total)) %>% 
  head(3)

# p.145. 06-6 집단별로 요약하기
exam %>% summarise(mean_math = mean(math))

exam %>% group_by(class) %>% 
  summarise(mean_math = mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n = n())

mpg <- as.data.frame(ggplot2::mpg)
mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head(10)
  
mpg %>% 
  group_by(manufacturer) %>% 
  filter(class=='suv') %>% 
  mutate(tot =(cty+hwy)/2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)
mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == 'suv') %>% 
  mutate(tot=(cty+hwy)/2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)
# q1
mpg <- as.data.frame(ggplot2::mpg)
mpg %>% 
  group_by(class) %>% 
  summarize(mean_cty = mean(cty))

# q2.
mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))
# q3.
mpg %>% 
  group_by(class) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

# q4.
mpg %>% 
  filter(class == 'compact') %>% 
  group_by(manufacturer) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count)) %>% 
  head(4)


# p.151. 06-07 데이터 합치기

test1 <- data.frame(id = c(1,2,3,4,5),
                    midterm = c(60,40,30,10,12))
test2 <- data.frame(id = c(1,2,3,4,5),
                    final = c(10,20,30,40,50))
total <- left_join(test1, test2, by = 'id')
head(total,3)

name <- data.frame(class = c(1,2,3,4,5),
                   teacher = c('kim', 'lee','park','choi','jung'))
name
exam_new <- left_join(exam, name, by ='class')
exam_new

group_a <- data.frame(id = c(1,2,3,4,5),
                      test = c(60,70,80,90,100))
group_b <- data.frame(id = c(6,7,8,9,10),
                      test = c(70,80,90,100,100))
group_a
group_b
group_all <- bind_rows(group_a, group_b)
group_all

# p.156. 혼자서 해보기
fuel <- data.frame(fl = c('c','d','e','p','r'),
                   price_fl = c(2.35,2.38,2.11,2.76,2.22),
                   stringsAsFactors = F)
fuel
# q1.
mpg <- as.data.frame(ggplot2::mpg)
head(mpg)
mpg <- left_join(mpg,fuel, by='fl')
str(mpg)

# q2.
mpg %>% 
  select('model','fl','price_fl') %>% 
  head(5)

# 정리하기
exam %>% filter(english>=80)
exam %>% filter(class == 1, english >= 80)
exam %>% filter(math >=90 | english >= 90)
exam %>% filter(class %in% c(1,3,5))
exam %>% select(math)
exam %>% select(class, math, english)

exam %>% 
  select(id, math) %>% 
  head(3)

exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class, math)

exam %>% 
  mutate(total = math +english + science)

exam %>% 
  mutate(total = math + english + science,
         mean = (math + english + science)/3) %>% 
  arrange(total)

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

mpg %>% 
  group_by(manufacturer,drv) %>% 
  summarise(mean_cty = mean(cty))

# 분석도전

# q1.

midwest <- as.data.frame(ggplot2::midwest)
midwest %>% 
  mutate(ratio_child = (poptotal-popadults)/poptotal*100)

# q2.
midwest %>% 
  arrange(desc(ratio_child)) %>% 
  select(county, ratio_child) %>% 
  head(5)
