data(Default, package="ISLR")
library(caret)

set.seed(1)
default_idx=createDataPartition(Default$default, p=0.75, list=FALSE)
default_trn=Default[default_idx, ]
default_tst=Default[-default_idx, ]

default_glm_mod=train(
    form=default~.,
    data=default_trn,
    trControl=trainControl(method="cv", number=5),
    method="glm",
    family="binomial"
)

trainControl(method="cv", number=5)[1:3]

default_glm_mod

names(default_glm_mod)
default_glm_mod$results
default_glm_mod$finalModel

summary(default_glm_mod)

calc_acc=function(actual, predicted){
  mean(actual == predicted)
}

head(predict(default_glm_mod, newdata=default_tst))

#test acc
calc_acc(actual=default_tst$default,
         predicted=predict(default_glm_mod, newdata=default_tst))

#get probs
head(predict(default_glm_mod, newdata=default_trn, type="prob"))

