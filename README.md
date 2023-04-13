# Bayes-xG-Model

## Aim: 

Use Bayesian methods to model the effects of various factors on the liklehood of a goal.

## Data: 

https://www.kaggle.com/datasets/aleespinosa/soccer-match-event-dataset

## Target Variable:

Binary variable (`is_goal`) indicating goal(1) or not(0).

## Predictors:
 - Binary variable describing whether the shot was part of a break (`is_CA`) 
 - Categorical variable describing what part of the body produced the shot (`body_part`)
 - Distance from the goal line (`dist`)
 - Angle to goal, below is an example of the angle described (`angle`)
 
 ![](./Sources/angles.jpg)
 
## Heirarchical Features:
 - We could add a grouping to the data through individual players (`playerId`)
 
## References:

- Pappalardo et al., (2019) A public data set of spatio-temporal match events in soccer competitions, Nature Scientific Data 6:236, https://www.nature.com/articles/s41597-019-0247-7

- Pappalardo et al. (2019) PlayeRank: Data-driven Performance Evaluation and Player Ranking in Soccer via a Machine Learning Approach. ACM Transactions on Intellingent Systems and Technologies (TIST) 10, 5, Article 59 (September 2019), 27 pages. DOI: https://doi.org/10.1145/3343172 
