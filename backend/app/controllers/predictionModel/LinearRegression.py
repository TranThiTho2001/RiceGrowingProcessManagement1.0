
import warnings
warnings.filterwarnings('ignore')
import numpy as np
import pandas as pd
import sys
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn import metrics

from sklearn.linear_model import OrthogonalMatchingPursuit
from sklearn.datasets import make_regression
import sys
import pickle
# # save the model to disk
import os
dr = os.getcwd()
filename = os.path.dirname(os.path.abspath(__file__))+"/ModelTrained/predictionByLinearRegression.sav"


lm = pickle.load(open(filename, 'rb'))

import json
temp = json.loads(sys.argv[1])
if sys.argv[1] == '1':
  yield_pr = lm.predict([[ 1,0,0, float(temp["precipitation"]), float(temp["temperature"]), float(temp["humitidity"]), float(temp["windSpeed"]), float(temp["solarRadiation"]), float(temp["area"]) ]])
  print(yield_pr)
elif sys.argv[1] == '2':
  yield_pr = lm.predict([[ 1,0,0, float(temp["precipitation"]), float(temp["temperature"]), float(temp["humitidity"]), float(temp["windSpeed"]), float(temp["solarRadiation"]), float(temp["area"]) ]])
  print(yield_pr)
else:
  yield_pr = lm.predict([[ 1,0,0, float(temp["precipitation"]), float(temp["temperature"]), float(temp["humitidity"]), float(temp["windSpeed"]), float(temp["solarRadiation"]), float(temp["area"]) ]])
  print(yield_pr)

sys.stdout.flush()

