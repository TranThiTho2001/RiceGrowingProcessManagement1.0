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
dataset = pd.DataFrame(pd.read_csv("D:/HOC/HK2_2022_2023/Luan_Van_Tot_Nghiep/Project/RiceGrowingProcessManagement1.0/backend/predictionModel/data4.csv"))
dataset.head()

X= dataset.iloc[:, :-1].values  
y= dataset.iloc[:, 5].values 
print(y)
from sklearn.preprocessing import LabelEncoder, OneHotEncoder  
from sklearn.compose import ColumnTransformer
labelencoder_x= LabelEncoder()  
X[:, 0]= labelencoder_x.fit_transform(X[:, 0])  
columnTransformer = ColumnTransformer([('encoder', OneHotEncoder(), [0])],     remainder='passthrough')
X=np.array(columnTransformer.fit_transform(X))
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.1, random_state=101)

# from sklearn.model_selection import KFold
# kf = KFold(n_splits=4, random_state=1, shuffle=True)
# for train_index, test_index in kf.split(X):
  # print("TRAIN:", train_index, "TEST:", test_index)
#   X_train, X_test = X[train_index], X[test_index]
#   y_train, y_test = y[train_index], y[test_index]


X, y = make_regression(noise=4, random_state=0)
reg = OrthogonalMatchingPursuit().fit(X_train, y_train)
reg.score(X_train, y_train)
predictions = reg.predict(X_test)
# lm = LinearRegression()
# lm.fit(X_train,y_train)
# predictions = lm.predict(X_test)
print(metrics.explained_variance_score(y_test, predictions))
print(metrics.mean_squared_error(y_test, predictions))
print('MAE:', metrics.mean_absolute_error(y_test, predictions))
print('MSE:', metrics.mean_squared_error(y_test, predictions))
print('RMSE:', np.sqrt(metrics.mean_squared_error(y_test, predictions)))
data = pd.DataFrame({"ThucTe(kg)":y_test,  "DuDoan(kg)": predictions, "ThucTe - DuDoan" :(y_test- predictions)})
print(data)


lm = LinearRegression()
lm.fit(X_train,y_train)
predictions = lm.predict(X_test)
print(metrics.explained_variance_score(y_test, predictions))
print(metrics.mean_squared_error(y_test, predictions))
print('MAE:', metrics.mean_absolute_error(y_test, predictions))
print('MSE:', metrics.mean_squared_error(y_test, predictions))
print('RMSE:', np.sqrt(metrics.mean_squared_error(y_test, predictions)))
data = pd.DataFrame({"ThucTe(kg)":y_test,  "DuDoan(kg)": predictions, "ThucTe - DuDoan" :(y_test- predictions)})
print(data)

# import pickle
# # save the model to disk
# filename = 'backend/predictionModel/ModelTrained/predictionByLinearRegression.sav'
# # pickle.dump(lm, open(filename, 'wb')) 
# loaded_model = pickle.load(open(filename, 'rb'))
print(lm.predict([[1,0,0, 21.3, 26.45, 75.58,2]]))