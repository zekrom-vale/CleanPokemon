library(tidyverse)
library(class)

# safe_table <-
#   train %>%
#   filter(!is.na(Age)) %>%
#   filter(!is.na(Fare))
#
# space_table <- safe_table %>% select(Age, Fare)
# class_table <- safe_table %>% select(Survived)

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

get_actual_classes <- function(cross_fold){
  test_rows <- cross_fold[[2]]
  fold_test <- class_table %>% slice(test_rows)
  fold_test$Survived
}

get_knn_predictions <- function(cross_fold, k){
  train_rows <- cross_fold[[1]]
  test_rows <- cross_fold[[2]]
  fold_train <- space_table %>% slice(train_rows)
  fold_classes <- class_table %>% slice(train_rows)
  fold_classes <- fold_classes[[1]]
  fold_classes <- factor(fold_classes)
  fold_test <- space_table %>% slice(test_rows)
  knn(fold_train, fold_test, fold_classes, k)
}

knn_error <- function(cross_fold, k){
  actual_classes <- get_actual_classes(cross_fold)
  predictions <- get_knn_predictions(cross_fold, k)
  predictions <- as.integer(levels(predictions)[predictions])
  errors <- abs(actual_classes - predictions)
  #errors <- errors[!is.na(errors)]
  error <- sum(errors )/length(errors)
}

get_cross_fold_knn_error <- function(table, nfolds, k){
  cross_folds <- make_cross_folds(table, nfolds)
  fold_errors <- sapply(cross_folds, knn_error, k)
  mean(fold_errors)
}

plot_errors <- function(table, nfolds = 10, n = 50){
  errors <- c()
  for (k in 1:n){
    error <- get_cross_fold_knn_error(table, nfolds, k)
    errors <- c(errors, error)
  }
  print(min(errors))
  ggplot(tibble(k = 1:n, error = errors), aes(k, error)) +
    geom_point() + geom_line()
}


