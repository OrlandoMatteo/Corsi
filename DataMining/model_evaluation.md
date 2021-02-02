# Model Evaluation

## Methods for performance evaluation
The objective is to have a reliable estimate of the performance. The
performance of the model may depend on other factors besides the learning
algorithm:

1. Class distribution
2. Cost of misclassification
3. size of training and test sets

### Learning Curve:
The learning curve show how accuracy changes with varying samples size, thus
it requires a sampling scheduls for creating a learning curve. You can use:

* Arithmetich sampling
* Geometric sampling

The effect os small sample size are the bias in the estimation and its
variance. There are different partition technique:

* holdout (you keep out a part of the data as test set)
* cross validation

### Holdout

Usually 2/3 of the data are used for training and 1/3 for testing. This
tecnique is appropriate for large datasets where the 

#### Cross validation 
Partition of the data in k disjiont subsets than train on k-1 partition ad
test on the reamining one. This is method has a reliable accuracy estimation
and not apprropriate for large datasets

#### Leave-one-out
Cross-validation for k=n. Only appropriate for very small datasets

## Metrics for model evaluation
Used to evaluate the predictive accuracy of a model. The *Confusion Matrix* is
used for binary classifier

### Accuracy
Accuracy has some limitation because it depends on the balance of the
datasets (positive vs. negative). *Accuracy* is not
appropriate for unbalanced class label distribution or if the class have
different importance (i.e medical cases). In this cases the right approach is
to evaluate separately for each class  with:

```math
Recall=Number of of objects correctly assigned to C/Number of objects
belonging to C
```
Precision(p)=Number of objects correcly assigned to C/Number of objects
assigned to C

### ROC (Recever Operating Characteristics)

The RoC Curve plots:
1. The True Positive Rate (TPR)= TP/(TP+FN)
2. The False Positive Rate(FPR)

