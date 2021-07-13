library(ggplot2)
# p.183 08-2 산점도 - 변수 간 관계 표현하기

ggplot(data=mpg, aes(x=displ, y=hwy))
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point()
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() + xlim(3,6) # x축 3~6

# p.189. 08-3 막대 그래프 - 집단 간 차이 표현하기
library(dplyr)
df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
df_mpg

ggplot(data = df_mpg, aes(x=drv, y=mean_hwy)) + geom_col()

# drv로 x열 배열하는데 mean_hwy기준으로 - 내림차순하겠다.

ggplot(data=df_mpg, aes(x = reorder(drv,-mean_hwy), y = mean_hwy)) +
  geom_col()

ggplot(data=mpg, aes(x=drv)) + geom_bar()
table(mpg$drv)

ggplot(data=mpg, aes(x=hwy)) + geom_bar()
table(mpg$hwy)

# p.194. 08-4 선그래프 - 시계열

str(economics)
ggplot(data = economics, aes(x=date, y=unemploy)) + geom_line()
ggplot(data = economics, aes(x =date, y=psavert)) + geom_line()

# 08-5 박스플롯 - 집단 간 분포 차이 표현하기

ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

# p.199 


