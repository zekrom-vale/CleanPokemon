formula <- as.formula("Survived ~ Pclass + Sex")

make_cross_folds <- function(table, nfolds){
  dims <- dim(table)
  nrows <- dims[1]
  rows <- 1:nrows
  rows <- sample(rows, nrows)
  
  fold_size <- floor(nrows / nfolds)
  last_fold_row <- nfolds * fold_size
  extra_start <- last_fold_row + 1
  extra_end <- nrows
  
  cross_folds <- list()
  for (i in 1:nfolds) {
    fold_end <- fold_size * i
    fold_start <- 1 + fold_end - fold_size
    
    fold_plus_extra <- c(fold_start:fold_end, extra_start:extra_end)
    test_rows <- rows[fold_plus_extra]
    train_rows <- setdiff(rows, test_rows)
    cross_folds[[i]] <- list(train_rows, test_rows)
    
  }
  cross_folds
}

get_actual_values <- function(cross_fold){
  test_rows <- cross_fold[[2]]
  fold_test <- train %>% slice(test_rows)
  fold_test$Survived
}

get_predictions <- function(cross_fold){
  train_rows <- cross_fold[[1]]
  test_rows <- cross_fold[[2]]
  fold_train <- train %>% slice(train_rows)
  fold_test <- train %>% slice(test_rows)
  model <- lm(formula, fold_train)
  predict(model, fold_test)
}

regression_error <- function(cross_fold){
  actual_values <- get_actual_values(cross_fold)
  predictions <- get_predictions(cross_fold)
  predictions <- if_else(predictions > 0.5, 1, 0)
  errors <- abs(actual_values - predictions)
  errors <- errors[!is.na(errors)]
  error <- sum(errors )/length(errors)
}

get_cross_fold_error <- function(table, nfolds = 10){
  cross_folds <- make_cross_folds(table, nfolds)
  fold_errors <- sapply(cross_folds, regression_error)
  mean(fold_errors)
}
