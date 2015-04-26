#!/usr/bin/python

from math import pow
import pandas as pd
import numpy as np
from sklearn import svm
from sklearn import cross_validation
from sklearn import grid_search
import pickle


# Return a list of numbers exponentially distributed in a range
def exp_range(start, end, e):
    retval = []
    while start < end:
        retval.append(start)
        start *= e
    return retval



folds = 4         # Folds for cross validation
perc_data = 0.01  # Percent of data to sample


# Load labeled input data
df = pd.read_csv('input/input.csv')


# Randomly select data (very small slice to begin with for performance reasons)
df['is_train'] = np.random.uniform(0, 1, len(df)) <= perc_data
# Yes, some of our test may show up as train too using this random method, below
# full set is better but prediction is longer
df['is_test'] = np.random.uniform(0, 1, len(df)) <= perc_data
#df['is_test'] = df['is_train'] == False
train_df = df[(df['is_train'])]
test_df = df[(df['is_test'])]
print "Selected", len(train_df), "training samples and", len(test_df), "testing samples."


feature_sets = {
                   "word": ['scaled_word_x0', 'scaled_word_y0'],
                   "line": ['scaled_word_x0', 'scaled_word_y0', 'scaled_line_x0', 'scaled_line_y0'],
                   "area": ['scaled_word_x0', 'scaled_word_y0', 'scaled_line_x0', 'scaled_line_y0', 'scaled_area_x0', 'scaled_area_y0']
               }

results = {}
for feat_name, features in feature_sets.iteritems():

    # Convert to numpy arrays with separate inputs and labels
    train_features = np.array(train_df[features])
    train_labels = np.array(train_df['label'], dtype=str) # see https://github.com/scikit-learn/scikit-learn/issues/2374
    test_features = np.array(test_df[features])
    test_labels = np.array(test_df['label'], dtype=str)
    #print test_labels[0:5]

    # Tune C and gamma through cross validation
    classifier = svm.SVC()
    cv = cross_validation.KFold(len(train_features), n_folds = folds)
    # Parameter ranges ref: page 5
    #param_grid = {"C": exp_range(pow(2, -5), pow(2, 15), 2), 
    #              "gamma": exp_range(pow(2, -15), pow(2, 3), 2)} 
    # Small testing range
    param_grid = {"C": [1, 10, 100], "gamma": [0, 0.001, 0.1]}
    gs = grid_search.GridSearchCV(classifier, param_grid=param_grid, cv=cv, verbose=1, n_jobs=-1)
    model = gs.fit(train_features, train_labels)
    print model.grid_scores_
    print model.best_score_
    print model.score(test_features, test_labels)

    # Single model with defaults
    classifier = svm.SVC()
    model = classifier.fit(train_features, train_labels)
    print model
    print model.score(test_features, test_labels)


with open('results.pickle', 'w') as f:
    pickle.dump(results, f)

#predictions = model.predict(test_features)
#accuracy = float(np.sum(predictions == test_labels)) / len(test_labels)
#print "Percent correct", accuracy

