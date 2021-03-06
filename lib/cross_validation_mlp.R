########################
### Cross Validation ###
########################

### Author: Chengliang Tang
### Project 3

cv.function <- function(train_df,nodesize = c(64,32), input_para,K){
  ### Input:
  ### - train data frame
  ### - K: a number stands for K-fold CV
  ### - tuning parameters 
  
  n <- dim(train_df)[1]
  n.fold <- round(n/K, 0)
  set.seed(0)
  s <- sample(rep(1:K, c(rep(n.fold, K-1), n-(K-1)*n.fold)))  
  cv.error <- rep(NA, K)
  
  for (i in 1:K){
    train.data <- train_df[s != i,]
    test.data <- train_df[s == i,] 
    model <- train_mlp(train_df = train.data,learnPara = input_para)
    input_test = test.data[,-which(names(test.data) == 'emotion_idx')]
    pred = test_mlp(model,input_test)
   
    error <- mean(pred != test.data$emotion_idx) 
    print(error)
    cv.error[i] <- error
    
  }			
  return(c(mean(cv.error),sd(cv.error)))
}