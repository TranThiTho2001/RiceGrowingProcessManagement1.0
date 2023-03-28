import numpy as np
import pandas as pd

from sklearn.model_selection import train_test_split
from sklearn import metrics
from sklearn.ensemble import RandomForestRegressor

dataset = pd.DataFrame(pd.read_csv("D:/HOC/HK2_2022_2023/Luan_Van_Tot_Nghiep/Project/RiceGrowingProcessManagement1.0/backend/predictionModel/data4.csv"))
dataset.head()
X= dataset.iloc[:, :-1].values  
y= dataset.iloc[:, 5].values 
from sklearn.preprocessing import LabelEncoder, OneHotEncoder  
from sklearn.compose import ColumnTransformer
labelencoder_x= LabelEncoder()  
X[:, 0]= labelencoder_x.fit_transform(X[:, 0])  
columnTransformer = ColumnTransformer([('encoder', OneHotEncoder(), [0])],     remainder='passthrough')
X=np.array(columnTransformer.fit_transform(X))
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.1, random_state=101)


RandomForestRegressor
model_RFR = RandomForestRegressor(n_estimators=10)
model_RFR.fit(X_train, y_train)
Y_pred2 = model_RFR.predict(X_test)
print(metrics.explained_variance_score(y_test, Y_pred2))
print('MAE:', metrics.mean_absolute_error(y_test, Y_pred2))
print('MSE:', metrics.mean_squared_error(y_test, Y_pred2))
print('RMSE:', np.sqrt(metrics.mean_squared_error(y_test, Y_pred2)))
data = pd.DataFrame({"ban đầu(kg)":y_test,  "  dự đoán(kg)": Y_pred2, "Chenh lech(thuc te-du doan)" :(y_test-Y_pred2)})
print(data)


# import pickle
# save the model to disk
# filename = 'backend/predictionModel/ModelTrained/predictionByRandomForestRegression.sav'
# pickle.dump(model_RFR, open(filename, 'wb')) 
# loaded_model = pickle.load(open(filename, 'rb'))

# print(loaded_model.predict([[0,1,0,1410, 27.23, 83.76,2]]))