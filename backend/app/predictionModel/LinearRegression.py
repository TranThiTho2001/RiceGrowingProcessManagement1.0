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
import os
dr = os.getcwd()
import json
print("ggt")
sys.stdout.flush()
file = dr + "/backend/app/predictionModel/data.csv"
df = pd.read_csv(file)
dataset = pd.DataFrame(pd.read_csv(file))
# total_cols=len(df.axes[1])
# print(str(total_cols))

X= dataset.iloc[:, :-1].values  
y= dataset.iloc[:, 7].values 

from sklearn.preprocessing import LabelEncoder, OneHotEncoder  
from sklearn.compose import ColumnTransformer
labelencoder_x= LabelEncoder()  
X[:, 0]= labelencoder_x.fit_transform(X[:, 0])  
columnTransformer = ColumnTransformer([('encoder', OneHotEncoder(), [0])],     remainder='passthrough')
X=np.array(columnTransformer.fit_transform(X))
# X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.1, random_state=101)

from sklearn.model_selection import KFold
kf = KFold(n_splits=4, random_state=1, shuffle=True)
for train_index, test_index in kf.split(X):
  X_train, X_test = X[train_index], X[test_index]
  y_train, y_test = y[train_index], y[test_index]

# -----------------OrthogonalMatchingPursuit **** MAE-671 RMSE 832
# X, y = make_regression(noise=4, random_state=0)
# reg = OrthogonalMatchingPursuit().fit(X_train, y_train)
# reg.score(X_train, y_train)
# predictions = reg.predict(X_test)
# # print(metrics.explained_variance_score(y_test, predictions))
# # print(metrics.mean_squared_error(y_test, predictions))
# print('MAE:', metrics.mean_absolute_error(y_test, predictions))
# print('MSE:', metrics.mean_squared_error(y_test, predictions))
# print('RMSE:', np.sqrt(metrics.mean_squared_error(y_test, predictions)))
# data = pd.DataFrame({"ThucTe(kg)":y_test,  "DuDoan(kg)": predictions, "ThucTe - DuDoan" :(y_test- predictions)})
# print(data)

# ---------LinearRegression ****Ok MAE 562 RME 704
# import json
# temp = json.loads(sys.argv[1])
# # print(temp["crop"])
# # input = sys.stdin.read()
# # print(json.loads(input))
lm = LinearRegression()
lm.fit(X_train,y_train)
predictions = lm.predict(X_test)

# if sys.argv[1] == '1':
#   yield_pr = lm.predict([[ 1,0,0, float(temp["precipitation"]), float(temp["temperature"]), float(temp["humitidity"]), float(temp["windSpeed"]), float(temp["solarRadiation"]), float(temp["area"]) ]])
#   print(yield_pr)
# elif sys.argv[1] == '2':
#   yield_pr = lm.predict([[ 1,0,0, float(temp["precipitation"]), float(temp["temperature"]), float(temp["humitidity"]), float(temp["windSpeed"]), float(temp["solarRadiation"]), float(temp["area"]) ]])
#   print(yield_pr)
# else:
#   yield_pr = lm.predict([[ 1,0,0, float(temp["precipitation"]), float(temp["temperature"]), float(temp["humitidity"]), float(temp["windSpeed"]), float(temp["solarRadiation"]), float(temp["area"]) ]])
#   print(yield_pr)

# print("ggt")
# sys.stdout.flush()
# yield_pr = lm.predict([[1,0,0, 21.3, 26.45, 75.58,2]])
# print('MAE:', metrics.mean_absolute_error(y_test, predictions))
# print('MSE:', metrics.mean_squared_error(y_test, predictions))
# print('RMSE:', np.sqrt(metrics.mean_squared_error(y_test, predictions)))
# data = pd.DataFrame({"ThucTe(kg)":y_test,  "DuDoan(kg)": predictions, "ThucTe - DuDoan" :(y_test- predictions)})
# print(data)


# ------ Decision Tree Regression **** MAE-799 RMSE-1043
# from sklearn import tree
# clf = tree.DecisionTreeClassifier()
# clf.fit(X_train, y_train)
# predictions = clf.predict(X_test)
# print('MAE:', metrics.mean_absolute_error(y_test, predictions))
# print('MSE:', metrics.mean_squared_error(y_test, predictions))
# print('RMSE:', np.sqrt(metrics.mean_squared_error(y_test, predictions)))
# data = pd.DataFrame({"ThucTe(kg)":y_test,  "DuDoan(kg)": predictions, "ThucTe - DuDoan" :(y_test- predictions)})
# print(data)


#--------GradientBoostingRegressor MAE: 582 RMSE 737
# from sklearn.preprocessing import StandardScaler
# sc = StandardScaler()
# X_train = sc.fit_transform(X_train)
# X_test = sc.transform(X_test)
# from sklearn.ensemble import GradientBoostingRegressor
# reg = GradientBoostingRegressor(random_state=0)
# reg.fit(X_train, y_train)
# predictions =  reg.predict(X_test)
# print('MAE:', metrics.mean_absolute_error(y_test, predictions))
# print('MSE:', metrics.mean_squared_error(y_test, predictions))
# print('RMSE:', np.sqrt(metrics.mean_squared_error(y_test, predictions)))
# data = pd.DataFrame({"ThucTe(kg)":y_test,  "DuDoan(kg)": predictions, "ThucTe - DuDoan" :(y_test- predictions)})
# print(data)

#------- KNeighborsRegressor MAE-715 RMSE 879
# from sklearn.neighbors import KNeighborsRegressor
# neigh = KNeighborsRegressor(n_neighbors=2)
# neigh.fit(X_train, y_train)
# predictions = neigh.predict(X_test)
# print('MAE:', metrics.mean_absolute_error(y_test, predictions))
# print('MSE:', metrics.mean_squared_error(y_test, predictions))
# print('RMSE:', np.sqrt(metrics.mean_squared_error(y_test, predictions)))
# data = pd.DataFrame({"ThucTe(kg)":y_test,  "DuDoan(kg)": predictions, "ThucTe - DuDoan" :(y_test- predictions)})
# print(data)


import pickle
# # save the model to disk backend\app\predictionModel\LinearRegression.py
filename = 'backend/app/predictionModel/ModelTrained/predictionByLinearRegression.sav'
pickle.dump(lm, open(filename, 'wb')) 
# lm = pickle.load(open(filename, 'rb'))
# # if sys.argv[1] == '1':
# #   yield_pr = lm.predict([[ 1,0,0, sys.argv[2],sys.argv[3],sys.argv[4], sys.argv[5], sys.argv[6], sys.argv[7] ]])
# # elif sys.argv[1] == '2':
# #   yield_pr = lm.predict([[ 0,1,0, sys.argv[2],sys.argv[3],sys.argv[4], sys.argv[5], sys.argv[6], sys.argv[7]  ]])
# # else:
# #   yield_pr = lm.predict([[ 0,0,1, sys.argv[2],sys.argv[3],sys.argv[4], sys.argv[5], sys.argv[6], sys.argv[7]  ]])

# print(sys.argv[2],sys.argv[3],sys.argv[4], sys.argv[5], sys.argv[6], sys.argv[7])
# sys.stdout.flush()
