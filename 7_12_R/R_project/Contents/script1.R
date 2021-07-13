## C:\Users\medici\master\7_12_R\R_project\Contents

a <- 1

b <- 2

c <- 3

d <- 3.5

a+b
# 변수 지정
## <-, <<-, = ->>, ->
## 전역변수

# encoding v.s. decoding
## encoding(사람이보는 내용을 바이너리로 바꾸는 것)과 decoding(그 반대) 형태가 같아야함


# 변수넣기 
## c (combination)
## num[1:5] 1~5 인덱스, 파이썬에서 메모리 사이즈 
## 파이썬과 다른점은 1~5-1이 아니라는 점

var1 <- c(1,2,5,7,8) # num
# 값들이 수치형으로 들어감. 뒤에 , 숫자 하면 포함됨
## R 수치형, bool형, 문자형 3가지 형식밖에 없음.



var1[2]
var2 <- c(1:5)  # int
# 얘는 타입이 정수형으로 추가가 불가능하다.
var2

var3 <- seq(1,5) # int

var4 <- seq(1, 10, by=2) 

var5<- seq(1, 10, by=3)


a+b

# broadcast  각 숫자에 더해지는  거. var1 + 2 # (1,2,3,4,5) + (2,2,2,2,2) = (3,4,5,6,7)
## 매핑이 된다는 얘기

str1 <- 'a'
str2 <- "b"

str2 <- "text"

str2 <- c("a","b","c") # chr 문자 타입, 하나의 변수임. 

str5 <- c("Hello","World","is","good!")
str1 + str2

str2 <- "text"
str3 <- "file"
str2 + str3  # concatrate안됨. 합성 할 수 없음

x <- c(1,2,3)
mean(x)
max(x)
min(x)

paste(str1, str2) # 오호라 

str5[0] # 값이 0이고 캐릭터다. 타입을 나타냄
str5[1]

a = paste(str5, collapse = ',') # "4개의 값을 하나로, 구분자로 ,를 쓰겠다" 라는 의미 // 쌍따옴표로 문자형 타입

#지금까지 넘버링, 문자형, 함수쓰는거 배움 이제 패키지 배우자
# 남을 설명할 수 있을 정도로 알 수 있어야 100% 아는 것.


03-3 함수 꾸러미, '패키지'이해하기 
#함수 from?은 패키지다.
## 지원해주지 않는 패키지 깔기

install.packages("ggplot2") # 패키지 이름은 문자형. 컴퓨터에서 한 번 찾아보고 없으니 서버에 가서 인스톨을 해라.
## https://cran.rstudio.com/bin/windows/Rtools/ 이 사이트에서 패키지를 가져온 것.
## C:\Users\Public\Documents\ESTsoft\CreatorTemp\Rtmps3AUY9\downloaded_packages 에 저장했다는 것
# 하드디스크에 저장한 것. 있다는 정보를 R한테 준 것.
## 메모리에 올라와야 실행이 가능함. 함수 꾸러미를 저장만 했지 실행하려면 메모리에 올려야함.
## 이 메모리에 올리는 동작이이 필요하다. = library라는 함수가 이 동작을 수행.

x <- c('a','a','b','c')
qplot(x)
library("ggplot2")
qplot(x) # 다 하나씩 읽어오는데 빈도수가 어떻게 되는지 계산한 다음 그림을 그려주는 함수이다.


qplot(data=mpg, x=hwy)
View(mpg)

qplot(data=mpg, x=hwy, bins=30)
qplot(data=mpg, x=cty, bins=30)
qplot(data=mpg, x=drv, y=hwy)
qplot(data=mpg, x=drv, y=hwy,geom="line") # 점으로 나타내진걸 선으로 나타내겠다.
qplot(data=mpg, x=drv, y=hwy,geom="boxplot", colour=drv)
?qplot


#           오후 시작

var1  <- c(80, 60, 70, 50, 90)
mean(var1)
mean_var1 <- mean(var1)
mean_var1
?mean

qplot(mean_var1)

# 패턴을 찾아내는 연습을 하자
## 변수는 속성?????
## 속성간의 관계는 컬럼
## 행이 많은 게 좋은가? 열이 많은 게 좋은가?
english <- c(90,80,60,70)
math <- c(50, 60, 100,20)
test <- c(10,20)

test[1]
test[2]

df_midterm <- data.frame(english, math) # 함수 내 변수는 달라도 되지만 변수 내에서는 같은 타입으로 묶여야한다.

df_midterm[1]
df_midterm[[1]]
df_midterm$english
#다양한 표현법
df_midterm$english[1][1] # 안됨
df_midterm[1,1]
df_midterm[[1]][1]

a <- 20
a
a[1]

# p.85 함수를 쓰는 이유, 프레임을 쓰는 이유(차원구조)
df_midterm

mean(df_midterm$english)
mean(df_midterm[1])
class(df_midterm$english) # numeric 타입
class(df_midterm[1]) # data.frame 타입, 평균값이 나오지 않는다.
class(df_midterm[[1]]) # numeric 타입
mean(df_midterm[[1]])

df_midterm <- data.frame(english = c(90, 70, 80, 90),
                         math = c(10,20,30,40),
                         class = c(1,1,2,1))
df_midterm # 컬럼의 데이터 수가 같아야 함.

# p.88 혼자풀어보기
제품 <- c('사과','딸기','수박')
가격 <- c(1800, 1500, 3000)
판매량 <- c(24,38,13)


fruits <- data.frame(제품, 가격, 판매량)
fruits
mean(fruits$가격)
mean(fruits$판매량)

install.packages("readxl")
library(readxl)

df_exam <- read_excel("./data/excel_exam.xlsx") #상대경로 (지금 현 장소에서)
View(df_exam)

mean(df_exam$english)

# p.92 
df_exam_novar <- read_excel("data/excel_exam_novar.xlsx",col_names = F)
View(df_exam_novar)

df_exam_sheet <- read_excel("data/excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet

df_csv_exam <- read.csv("data/csv_exam.csv")
df_csv_exam

# 변수 타입을 볼때는 class 사용
class(df_csv_exam)
mean(df_csv_exam$math)

df_csv_exam <- read.csv("data/csv_exam.csv", stringsAsFactors = F)
head(df_csv_exam)

# p.95
df_midterm <- data.frame(english = c(90,80, 60, 70),
                         math = c(10,20,30,40),
                         class = c(1,2,1,1))
head(df_midterm,3)

# p.98 정리하기
english <- c(10,20,20,30)
math <- c(100,20,50,40)
data.frame(english, math)

df_midterm
write.csv(df_midterm, file = "data/df_midterm.csv")
saveRDS(df_midterm, file="data/df_midterm.rds")



library(readxl)
df_excel_exam <- read_excel("data/excel_exam.xlsx")
df_csv_exam <- read.csv("data/df_midterm.csv")
saveRDS(df_midterm, file = "data/df_midterm.rds")

rm(df_midterm)
df_midterm <- readRDS("df_midterm.rds")
df_midterm

exam <- read.csv("data/csv_exam.csv")
tail(exam,10)

# p.100. 05-1 데이터 파악하기

# str # structure 구조, 속성의 데이터 타입임.
str(exam)
dim(exam)
summary(exam)

install.packages("ggplot2")
mpg <- as.data.frame(ggplot2::mpg)
head(mpg)
tail(mpg)
dim(mpg)
str(mpg)
summary(mpg)

# p.110. 05-2 변수명 바꾸기.
df_raw <- data.frame(var1 = c(1,2,3),
                     var2 = c(2,3,2))
df_raw

install.packages(('dplyr'))
library(dplyr)
df_new <- df_raw
df_new
df_new <- rename(df_new, v2 = var2)

# p.112. 혼자서 해보기
head(mpg,3)

mpg <- rename(mpg,city=cty,highway = hwy)
summary(mpg)
head(mpg,3)

# p.113. 05-3 파생변수 만들기
df <- data.frame(var1 = c(4,3,8),
                 var2 = c(2,6,1))
df$var_sum <- df$var1 + df$var2
df
df$var_mean <- (df$var1 + df$var2)/2
df
str(mpg)

a <- c(1,2,3)
b <- c(2,3,4)
a+b

View(mpg)

mpg <- as.data.frame(ggplot2::mpg)
mpg$total <- (mpg$cty + mpg$hwy)/2
head(mpg)

mean(mpg$total)
summary(mpg$total)
hist(mpg$total)
min(mpg$total)


mpg$test <- ifelse(mpg$total >=20, 'pass','fail')
head(mpg)


table(mpg$test)
library(ggplot2)
qplot(mpg$test)
s
# p.120
mpg$grade <- ifelse(mpg$total >=30, "A",
                    ifelse(mpg$total >= 20, "B",
                           ifelse(mpg$total >=15,"C","D")))
head(mpg,10)
table(mpg$grade)
qplot(mpg$grade)

midwest <- as.data.frame(ggplot2::midwest)
midwest$total <- rename(midwest, total = poptotal)
head(midwest)

