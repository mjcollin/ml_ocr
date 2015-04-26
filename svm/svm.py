#!/usr/bin/python

import pandas as pd
import numpy as np
from sklearn import svm
from sklearn import cross_validation
from sklearn import grid_search

df = pd.read_csv('input/input.csv')

# Randomly select data (very small slice to begin with)
df['is_train'] = np.random.uniform(0, 1, len(df)) <= 0.01
df['is_test'] = np.random.uniform(0, 1, len(df)) <= 0.01 # Yes, some of our test may show up as train too
#df['is_test'] = df['is_train'] == False
train_df = df[(df['is_train'])]
test_df = df[(df['is_test'])]
print "Selected", len(train_df), "training samples and", len(test_df), "testing samples."
#print train_df.head()

# Convert to numpy arrays with separate inputs and labels
features = ['scaled_word_x0', 'scaled_word_y0']
#features = ['scaled_word_x0', 'scaled_word_y0', 'scaled_line_x0', 'scaled_line_y0']
train_features = np.array(train_df[features])
train_labels = np.array(train_df['label'])
test_features = np.array(test_df[features])
test_labels = np.array(test_df['label'])
#print test_labels[0:5]

#print "Features", train_features.shape
#print "Labels", train_labels.shape


# Tune C and gamma


classifier = svm.SVC()
model = classifier.fit(train_features, train_labels)
print model

predictions = model.predict(test_features)
accuracy = float(np.sum(predictions == test_labels)) / len(test_labels)
print "Percent correct", accuracy

#print model.score(test_features, test_labels)
