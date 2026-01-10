options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
proc r;
export data=workx.iris20260101_train r=iris20260101_train;
submit;
library(dplyr)
iris20260101_train$species2 <- with(iris20260101_train,
case_when(Sepal_Length >= 4.65 & Petal_Width < 0.8 ~ "setosa", 
    Petal_Length < 4.75 & Petal_Width >= 0.8 ~ "versicolor", 
    Sepal_Length < 4.55 & Sepal_Length < 4.65 & Petal_Width < 
        0.8 ~ "setosa", Petal_Length < 1.2 & Sepal_Length >= 
        4.55 & Sepal_Length < 4.65 & Petal_Width < 0.8 ~ "setosa", 
    Sepal_Length < 5.95 & Petal_Length < 4.85 & Petal_Length >= 
        4.75 & Petal_Width >= 0.8 ~ "versicolor", Petal_Width >= 
        1.75 & Petal_Length >= 4.85 & Petal_Length >= 4.75 & 
        Petal_Width >= 0.8 ~ "virginica", Sepal_Width < 3.3 & 
        Petal_Length >= 1.2 & Sepal_Length >= 4.55 & Sepal_Length < 
        4.65 & Petal_Width < 0.8 ~ "setosa", Sepal_Width >= 3.3 & 
        Petal_Length >= 1.2 & Sepal_Length >= 4.55 & Sepal_Length < 
        4.65 & Petal_Width < 0.8 ~ "versicolor", Sepal_Length < 
        6.5 & Sepal_Length >= 5.95 & Petal_Length < 4.85 & Petal_Length >= 
        4.75 & Petal_Width >= 0.8 ~ "virginica", Sepal_Length >= 
        6.5 & Sepal_Length >= 5.95 & Petal_Length < 4.85 & Petal_Length >= 
        4.75 & Petal_Width >= 0.8 ~ "versicolor", Petal_Width < 
        1.55 & Petal_Width < 1.75 & Petal_Length >= 4.85 & Petal_Length >= 
        4.75 & Petal_Width >= 0.8 ~ "virginica", Petal_Length < 
        5.45 & Petal_Width >= 1.55 & Petal_Width < 1.75 & Petal_Length >= 
        4.85 & Petal_Length >= 4.75 & Petal_Width >= 0.8 ~ "versicolor", 
.default = "virginica"))
head(iris20260101_train)
endsubmit;
import data=workx.iris_from_tree r=iris20260101_train;
run;quit;
