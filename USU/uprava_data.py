import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn import preprocessing
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, MinMaxScaler, Normalizer # tri druhy skalovani
from sklearn.linear_model import LogisticRegression
from sklearn.neighbors import KNeighborsClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
from sklearn.model_selection import train_test_split # pro rozdeleni  dat
from sklearn.model_selection import KFold # pouziti cross validace
from sklearn.pipeline import Pipeline


df = pd.read_csv("data/weatherAUS.csv")
df["avg_pressure"] = (df['Pressure3pm']+df['Pressure9am'])/2

df_r = df[['Date', 'Location', 'MinTemp', 'MaxTemp', 'Rainfall', 'avg_pressure','RainToday', 'RainTomorrow']].copy()
df_r = df_r.dropna()

y = preprocessing.LabelEncoder().fit_transform(df_r['RainTomorrow']) # prekoduj si na to zda prselo, ci ne
t = pd.to_datetime(df_r["Date"]).dt.day_of_year


X = pd.DataFrame()
X["sint"] = np.sin(2*3.14/365.25*t)
X["cost"] = np.cos(2*3.14/365.25*t)
X['MinTemp'] = df_r['MinTemp']
X['MaxTemp'] = df_r['MaxTemp']
X['Rainfall'] = df_r['Rainfall']
X['avg_pressure'] = df_r['avg_pressure']
X['Location'] = preprocessing.OrdinalEncoder().fit_transform(df_r['Location'].values.reshape(-1,1)) # mozna onehot
X["RainToday"] = preprocessing.OrdinalEncoder().fit_transform(df_r['RainToday'].values.reshape(-1,1))
X = X.dropna()


seed = 42
X_tr, X_test, y_tr, y_test = train_test_split(X, y, test_size=0.2, random_state=seed, stratify=y)

pipe_mm_lrc = Pipeline([('scaler', MinMaxScaler()),('classifier', LogisticRegression(C=1, penalty="l1", solver="liblinear"))])
pipe_mm_lrc2 = Pipeline([('scaler', MinMaxScaler()),('classifier', LogisticRegression(C=1/2, penalty="l1", solver="liblinear"))])
# pipe_mm_knn7 = Pipeline([('scaler', MinMaxScaler()),('classifier', KNeighborsClassifier(n_neighbors=7))])
# pipe_mm_forest = Pipeline([('scaler', MinMaxScaler()),('classifier', RandomForestClassifier(max_depth=None, n_estimators=300, random_state=0))])
pipe_sc_lrc = Pipeline([('scaler', StandardScaler()),('classifier', LogisticRegression(C=1, penalty="l1", solver="liblinear"))])
pipe_sc_lrc2 = Pipeline([('scaler', StandardScaler()),('classifier', LogisticRegression(C=1/2, penalty="l1", solver="liblinear"))])

# pipe_sc_knn7 = Pipeline([('scaler', StandardScaler()),('classifier', KNeighborsClassifier(n_neighbors=7))])
# pipe_sc_forest300 = Pipeline([('scaler', StandardScaler()),('classifier', RandomForestClassifier(max_depth=None, n_estimators=300, random_state=0))])

# pipe_mm_lr           0.810051
# pipe_mm_forest300    0.827222
# pipe_mm_knn7         0.806171
# pipe_sc_lr           0.810328
# pipe_sc_knn7         0.804137
# pipe_sc_forest300    0.827123

# pipes = {
    # "pipe_mm_lr": pipe_mm_lr,
    # "pipe_mm_forest300": pipe_mm_forest300,
    # "pipe_mm_knn7": pipe_mm_knn7,
    # "pipe_sc_lr" : pipe_sc_lr,
    # "pipe_sc_knn7" : pipe_sc_knn7,
    # "pipe_sc_forest300" : pipe_sc_forest300
# }
pipes = {"pipe_mm_lrc" : pipe_mm_lrc,
         "pipe_mm_lrc2" : pipe_mm_lrc2,
         "pipe_sc_lrc" : pipe_sc_lrc,
         "pipe_sc_lrc2" : pipe_sc_lrc2}
results = { pipe_name: [] for pipe_name in pipes.keys()}
X_tr, X_test, y_tr, y_test = train_test_split(X,y, test_size=0.2,random_state=seed)
kf = KFold(n_splits=5, shuffle=True)
for train_index, test_index in kf.split(X_tr, y_tr):
  X_fold_tr = X_tr.values[train_index]
  y_fold_tr = y_tr[train_index]
  X_fold_test = X_tr.values[test_index]
  y_fold_test = y_tr[test_index]
  for k, pipe in pipes.items():
    pipe.fit(X_fold_tr, y_fold_tr)
    results[k].append(pipe.score(X_fold_test,y_fold_test))
results = pd.DataFrame(data = results)
print(results)
print(results.mean())



