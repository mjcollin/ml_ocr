#!/usr/bin/python

import pandas as pd
import numpy as np
from sklearn import svm

df = pd.read_csv('input/input.csv')

# Randomly select data (very small slice to begin with)
df['is_train'] = np.random.uniform(0, 1, len(df)) <= 0.01
df['is_test'] = np.random.uniform(0, 1, len(df)) <= 0.01 # Yes, some of our test may show up as train too
train_df = df[(df['is_train'])]
test_df = df[(df['is_test'])]
print "Selected", len(train_df), "training samples and", len(test_df), "testing samples."
print train_df.head()

# Convert to numpy arrays with separate inputs and labels
train_features = np.array(train_df[['scaled_word_x0', 'scaled_word_y0']])
train_labels = np.array(train_df['label'])
test_features = np.array(test_df[['scaled_word_x0', 'scaled_word_y0']])
test_labels = np.array(test_df['label'])

print "Features", train_features.shape
print "Labels", train_labels.shape

classifier = svm.SVC()
model = classifier.fit(train_features, train_labels)
predictions = model.predict(test_features)
print model
print np.sum(predictions == test_labels)
