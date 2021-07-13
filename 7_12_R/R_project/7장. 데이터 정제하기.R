# 07-1 결측치 정제하기

library(dplyr)
df <- data.frame(sex = c("M","F",NA,"M","F"),
                 score = c(5,4,3,4,NA))
df
is.na(df)
table(is.na(df))
table(is.na(df$score))

mean(df$score)
# 결측치가 하나라도 있으면 값이 NA로 나옴.
## 평균값으로 세팅하거나 결측치를 제거하거나

df %>% filter(is.na(score))
df %>% filter(!is.na(score))

df_nomiss <- df %>% filter(!is.na(score))
mean(df_nomiss$score)
sum(df_nomiss$score)
# (1)
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss
# (2)
df_nomiss2 <- na.omit(df)
df_nomiss2
# (3)
# na.rm = NA remove, 집계함수가 있고 지원이 안되면 위에처럼 해야한다.
mean(df$score, na.rm = T)
sum(df$score, na.rm = T)

exam <- read.csv('data/csv_exam.csv')
head(exam)
exam
exam[3]
exam[c(3,8,15),"math"] <- NA

exam %>% summarise(mean_math = mean(math, ra.rm = T))

head(exam)
exam[3,2]
exam[3]
ex <- data.frame(id = c(1,2,3,4),
                 class = c(6,7,8,9))
ex
class(ex)
ex[1]
ex[1,2]
# 이거 행, 열 순서로 나오는 거임 헷갈리니까 한 번 더 보자

exam %>% summarise(mean_math = mean(math)) # 평균 산출
exam %>% summarise(mean_math = mean(math, na.rm =T))

exam %>% summarise(mean_math = mean(math, na.rm = T),
                   sum_math = sum(math, ra.rm = T),
                   median_math = median(math, na.rm = T))
View(exam)

mean(exam$math, na.rm =T)
exam$math <- ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))

mean(exam$math)

# p.170 혼자서 해보기

mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65,124,131,153,212), "hwy"] <- NA

table(is.na(mpg$drv))
table(is.na(mpg$hwy))

mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))

# p.171 07-2 이상치 정제하기 -> 결측치로

outlier<- data.frame(sex = c(1,2,1,3,2,1),
                     score = c(5,4,3,4,2,6))
table(outlier$sex)
table(outlier$score)
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats

mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy >37, NA, mpg$hwy)
table(is.na(mpg$hwy))

mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm =T))

mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10,14,58,93),'drv'] <-'k'
mpg[c(29,43,129,203), 'cty'] <- c(3,4,39,42)
