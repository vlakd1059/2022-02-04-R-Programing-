# ggplot2 패키지 설치
install.packages("ggplot2")
# 패키지 로딩
library(ggplot2)
# ggplot2 패키지는 시각화를 손쉽게 해주는 전용 패키지
library(dplyr)

# 연습용 데아터
# mpg(1999~2008년 사이 미국에서 출시된 자동차 234종 연비관련 정보)
mpg
View(mpg) 
str(mpg)
#  tibble 형태의 데이터를 dataframe구조로 변경하는 방법
mpg=data.frame(mpg)

mpg
# ggplot 3단계 구조
# 1. 축 설정 2. 그래프 설정 3. 추가설정
# x축은 배기량, y축은 고속도로 연비를 각 위치에 데이터를
# 산점도로 표현
# aes => 축설정
ggplot(mpg, aes(x=displ, y=hwy))+geom_point(size=3,color="#4169E1")+xlim(3,6)+ylim(10,30)+
  labs(x="배기량",y="연비")+theme(axis.title.x=element_text(size = 30), axis.title.y=element_text(size=30))

# 구동방식(div) 배기량에 따른 고속도로 연비를 시각화
# color안의 기준점이 범주형인 경우
# 각각 전혀 다른 색상으로 표현이 된다
ggplot(mpg,aes(x=displ, y=hwy, color=drv))+geom_point(size=4)

# color안의 기준점이 수치형인 경우
ggplot(mpg,aes(x=displ, y=hwy, color=cyl))+geom_point(size=4)

#  추세선 그리기 geom_smooth()

ggplot(mpg,aes(x=displ, y=hwy, color=cyl))+geom_point(size=4)+ geom_smooth()


# 막대그래프
# 실습) 제조회사별 고속도로 평균연비 출력

manu_hwy = mpg %>%   group_by(manufacturer) %>% summarise(mean_hwy = mean(hwy))
manu_hwy

# 막대그래프 그리는방법
# reorder가 mean_hwy기준으로 정렬
ggplot(manu_hwy, aes(x=reorder(manufacturer, -mean_hwy), y=mean_hwy))+geom_col()

# 실습) 제조회사별 구동방식별 평균 고속도로 연비 평균 출력
mdh= mpg %>%group_by(manufacturer , drv) %>%  summarise(mean_hwy = mean(hwy))
mdh
ggplot(mdh, aes(x=manufacturer, mean_hwy))+geom_col(aes(fill=drv))


# 구동방식(drv)별 빈도수 그래프
# 빈도그래프를 그릴때 y축이 빈도수로 결정되기 때문에 y축을 지정하지 않는다. 
ggplot(mpg, aes(x=drv))+geom_bar()

# 제조회사별 차종별 빈도그래프
ggplot(mpg, aes(x=manufacturer))+geom_bar(aes(fill=class))


list.files()




 
titanic<-read.csv("titanic_2.csv",stringsAsFactors = T)
titanic$Survived <- factor(titanic$Survived)
summary(titanic)
titanic$Pclass <- factor(titanic$Pclass)
summary(titanic)
titanic$Embarked <-factor(titanic$Embarked)
titanic$Sex <- factor(titanic$Sex)
titanic$Cabin <- as.character(titanic$Cabin)
titanic$Cabin <- substr(titanic$Cabin,1,1) 
titanic$Cabin <- ifelse(titanic$Cabin=="","Z",titanic$Cabin)
titanic <- titanic %>% mutate(FamilySize=SibSp+Parch+1)

titanic <- titanic %>% mutate(FamilyLevel = ifelse(FamilySize == 1, "Single", ifelse(FamilySize <= 4, "Small", "Large")))

titanic <- titanic %>%  filter(Cabin !="Z")
ggplot(data=titanic, aes(x=Cabin))+geom_bar(aes(fill=Survived), position = "dodge")
