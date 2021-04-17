default_knn_mod=train(
  default~.,
  data=default_trn,
  method="knn",
  trControl=trainControl(method="cv", number=5)
)

default_knn_mod

#add tuning
default_knn_mod=train(
  default~.,
  data=default_trn,
  method="knn",
  trControl=trainControl(method="cv", number=5),
  preProcess=c("center","scale"),
  tuneGrid=expand.grid(k=seq(1,101,by=2))
)

head(default_knn_mod$results, 5)
plot(default_knn_mod)

ggplot(default_knn_mod)+theme_bw()

default_knn_mod$bestTune

get_best_result=function(caret_fit){
  best=which(rownames(caret_fit$results)== rownames(caret_fit$bestTune))
  best_result=caret_fit$results[best, ]
  rownames(best_result)=NULL
  best_result
}

get_best_result(default_knn_mod)

default_knn_mod$finalModel

head(predict(default_knn_mod, newdata=default_tst, type="prob"))




