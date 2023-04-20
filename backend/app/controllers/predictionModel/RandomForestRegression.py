import numpy as np
import pandas as pd

from sklearn.model_selection import train_test_split
from sklearn import metrics
from sklearn.ensemble import RandomForestRegressor

dataset = pd.DataFrame(pd.read_csv("D:/HOC/HK2_2022_2023/Luan_Van_Tot_Nghiep/Project/RiceGrowingProcessManagement1.0/backend/predictionModel/data2.0.csv"))
print(dataset)
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

# RandomForestRegressor MAE-599, 582, 581, 596    RMSE-712, 745, 731, 741
# model_RFR = RandomForestRegressor(n_estimators=10)
# model_RFR.fit(X_train, y_train)
# Y_pred2 = model_RFR.predict(X_test)
# print('MAE:', metrics.mean_absolute_error(y_test, Y_pred2))
# print('MSE:', metrics.mean_squared_error(y_test, Y_pred2))
# print('RMSE:', np.sqrt(metrics.mean_squared_error(y_test, Y_pred2)))
# data = pd.DataFrame({"ban đầu(kg)":y_test,  "  dự đoán(kg)": Y_pred2, "Chenh lech(thuc te-du doan)" :(y_test-Y_pred2)})
# print(data)


# import pickle
# save the model to disk
# filename = 'backend/predictionModel/ModelTrained/predictionByRandomForestRegression.sav'
# pickle.dump(model_RFR, open(filename, 'wb')) 
# loaded_model = pickle.load(open(filename, 'rb'))

# print(loaded_model.predict([[0,1,0,1410, 27.23, 83.76,2]]))








# import warnings
# warnings.filterwarnings('ignore')
# import numpy as np
# import pandas as pd
# import sys
# from sklearn.model_selection import train_test_split
# from sklearn.linear_model import LinearRegression
# from sklearn import metrics

# from sklearn.linear_model import OrthogonalMatchingPursuit
# from sklearn.datasets import make_regression
# import os
# dr = os.getcwd()
# import json

# sys.stdout.flush()
# file = os.path.dirname(os.path.abspath(__file__))+"/data.csv"

# dataset = pd.DataFrame(pd.read_csv(file))
# dataset.head()

# X= dataset.iloc[:, :-1].values  
# y= dataset.iloc[:, 7].values 

# from sklearn.preprocessing import LabelEncoder, OneHotEncoder  
# from sklearn.compose import ColumnTransformer
# labelencoder_x= LabelEncoder()  
# X[:, 0]= labelencoder_x.fit_transform(X[:, 0])  
# columnTransformer = ColumnTransformer([('encoder', OneHotEncoder(), [0])],     remainder='passthrough')
# X=np.array(columnTransformer.fit_transform(X))
# # X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.1, random_state=101)

# from sklearn.model_selection import KFold
# kf = KFold(n_splits=4, random_state=1, shuffle=True)
# for train_index, test_index in kf.split(X):
#   X_train, X_test = X[train_index], X[test_index]
#   y_train, y_test = y[train_index], y[test_index]

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
# lm = LinearRegression()
# lm.fit(X_train,y_train)
# predictions = lm.predict(X_test)

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


# import pickle
# # # save the model to disk
# filename = 'backend/app/controllers/predictionModel/ModelTrained/predictionByLinearRegression.sav'
# pickle.dump(lm, open(filename, 'wb')) 
# np = pickle.load(open(filename, 'rb'))
# import json
# temp = json.loads(sys.argv[1])
# if sys.argv[1] == '1':
#   yield_pr = lm.predict([[ 1,0,0, float(temp["precipitation"]), float(temp["temperature"]), float(temp["humitidity"]), float(temp["windSpeed"]), float(temp["solarRadiation"]), float(temp["area"]) ]])
#   print(yield_pr)
# elif sys.argv[1] == '2':
#   yield_pr = lm.predict([[ 1,0,0, float(temp["precipitation"]), float(temp["temperature"]), float(temp["humitidity"]), float(temp["windSpeed"]), float(temp["solarRadiation"]), float(temp["area"]) ]])
#   print(yield_pr)
# else:
#   yield_pr = lm.predict([[ 1,0,0, float(temp["precipitation"]), float(temp["temperature"]), float(temp["humitidity"]), float(temp["windSpeed"]), float(temp["solarRadiation"]), float(temp["area"]) ]])
#   print(yield_pr)

# print(np.predict([[0,1,0,1410, 27.23, 83.76,45,78,2]]))
# sys.stdout.flush()

# sys.stdout.flush()
