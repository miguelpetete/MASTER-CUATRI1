#!/usr/bin/env python
# coding: utf-8

# _Aprendizaje Automático_
# 
# _Máster Universitario en Inteligencia Artificial_
# 
# # Laboratorio: Regresión lineal y árboles de decisión para tareas de regresión
# 
# 
# ## Objetivos
# 
# Mediante esta actividad se pretende que ponga en práctica los pasos para la resolución de un problema de machine learning, el tratamiento de datos y la creación de modelos basados en regresión lineal y árboles de decisión. El objetivo es comprender de forma práctica con un problema determinado las diferencias que existen a la hora de entrenar los diferentes modelos.
# 
# - Iniciarse en el Análisis Exploratorio de Datos (EDA) para los problemas de Machine Learning.
# - Entender y aplicar los conceptos de la Regresión Lineal Múltiple a un problema de regresión.
# - Entender y aplicar los conceptos de Árboles de Decisión a un problema de regresión.
# - Evaluar y analizar los resultados de los clasificadores.
# - Investigar la aplicación de los modelos de clasificación a problemas reales.
# 
# 
# ## Descripción de la actividad
# 
# Debes completar los espacios indicados en el notebook con el código solicitado y la respuesta, en función de lo que se solicite. Ten encuenta que las celdas vacías indican cuántas líneas debe ocupar la respuesta, por lo general no más de una línea.
# 
# El conjunto de datos con el que vamos a trabajar se encuentra en el siguiente enlace: https://archive.ics.uci.edu/dataset/360/air+quality
# 
# Se trata de un dataset con un conjunto de datos sobre calidad del aire. El conjunto de datos contiene 9358 instancias de respuestas promediadas por hora de una matriz de 5 sensores químicos de óxido de metal integrados en un dispositivo multisensor químico de calidad del aire. El dispositivo estaba ubicado en un área significativamente contaminada, al nivel de la carretera, dentro de una ciudad italiana. Los datos se registraron desde marzo de 2004 hasta febrero de 2005 (un año).
# 
# El objetivo de la regresión será predecir la calidad del aire para un determinado día.
# 
# ### Tareas que se deben realizar
# 
# - Análisis descriptivo de los datos:
#    - Debe completarse el código solicitado y responder a las preguntas. Todo ello en el notebook dado como base.
# - Regresión:
#   - Debe completarse el código solicitado y responder a las preguntas. Todo ello en el notebook dado como base.
# - Investigación:
#   - Buscar un artículo científico (https://scholar.google.es/) con un caso de uso de regresión empleando una de las dos técnicas (o ambas) vistas en la actividad. Los artículos deben estar en revistas científicas, y deben ser posteriores a 2015. No debe utilizar técnicas de Deep Learning.
#   - Para el artículo indicar:
#     - Objetivo: cuál es el objetivo de la investigación, es decir a qué problema real está aplicando la regresión.
#     - Cómo utilizan las técnicas de regresión, si realizan alguna adaptación de los algoritmos indicarse.
#     - Principales resultados de la aplicación y de la investigación.
# 

# ### Análisis descriptivo de los datos
# A continuación vas a encontrar una serie de preguntas que tendrás que responder. Para responder tendrás que escribir (y ejecutar) una (o más de una) línea de código, y a continuación indicar la respuesta en la celda indicada.

# In[1]:


import pandas as pd
import numpy as np
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LinearRegression
from sklearn.tree import DecisionTreeRegressor
from sklearn.metrics import mean_absolute_error, r2_score, mean_squared_log_error
import matplotlib.pyplot as plt


# In[2]:


## cargar el dataset
df = pd.read_csv('AirQualityUCI.csv', sep=';')


# In[3]:


df.head()


# In[4]:


## ¿cuántas instancias tiene el dataset?
num_instancias = df.shape[0]
num_instancias


# In[5]:


## ¿cuál es el tipo de datos de cada una de las columnas?
df.info()


# In[6]:


valores_unicos = df['PT08.S3(NOx)'].unique()
print(valores_unicos)
print(len(valores_unicos))


# In[7]:


## ¿cuántas columnas categóricas hay? ¿y cuántas continuas?


# In[17]:


categorical_columns = df.select_dtypes(include=['object']).columns
continuous_columns = df.select_dtypes(include=[np.number]).columns

num_categorical = len(categorical_columns)

print(f'Columnas categóricas: {num_categorical}')


# In[18]:


num_continuous = len(continuous_columns)
print(f'Columnas continuas: {num_continuous}')


# In[10]:


## ¿existen valores nulos en el dataset?


# In[21]:


num_valores_nulos = df.isnull().sum().sum()
print(f'Número de valores nulos: {num_valores_nulos}')


# _indica aquí tu respuesta_

# In[11]:


## ¿cuál es la variable respuesta?¿de qué tipo es?


# In[22]:


df.columns


# In[ ]:





# In[12]:


## Si te fijas en los estadísticos del dataset, ¿cómo es la distribución de las variables, CO, NOx y NO2? 


# ¿Estas variables muestran alguna distribución especial?¿Tienen datos faltantes?¿y datos anómalos?

# RESPUESTA AQUÍ

# In[13]:


## ¿cómo son las correlaciones entre las variables del dataset?


# In[14]:


## ¿qué tres variables son las más correlacionadas con la variable objetivo?


# In[15]:


## ¿existe alguna variable que no tenga correlación?


# En base al EDA realizado, ¿qué suposiciones se pueden hacer sobre los datos?¿qué conclusiones extraes para implementar el modelo predictivo?

# _indica aquí tu respuesta_

# ### Regresión
# 
# Para llevar a cabo la tarea de regresión deseada se pretender hacer una comparativa de varios modelos. Unos usarán el algortimo de regresión lineal, y otros realizarán la predicción haciendo uso de árboles de decisión.
# 
# Para los primeros modelos hay que usar el módulo https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LinearRegression.html 
# 
# El algortimo de Regresión Lineal necesita saber cuáles son las variables que va a tener en cuenta para realizar la estimación.
# 
# El primero modelo que se debe construir usará una regresión lineal simple. Para ello sigue los siguientes pasos.

# Antes de empezar con la implementación de los modelos hace falta realizar una transformación de datos, escalarlos.

# In[16]:


from sklearn.preprocessing import MinMaxScaler
from pandas import DataFrame


scaler = StandardScaler()

X_train = DataFrame(scaler.fit_transform(X_train))
X_test = DataFrame(scaler.fit_transform(X_test))


# In[ ]:


# separar datos de entrenamiento y test


# In[ ]:





# In[ ]:


# escoger la variable que a partir del EDA realizado, consideres que mejor va a realizar la predicción


# In[ ]:





# In[ ]:


# entrena el modelo con los datos de entrenamiento


# In[ ]:





# In[ ]:


# ¿cuáles son los valores aprendidos por el modelo para los parámetros?


# In[ ]:





# Explica qué indican estos parámetros

# _indica aquí tu respuesta_

# In[ ]:





# In[ ]:


# realiza las predicciones para el conjunto de datos de test


# In[ ]:





# In[ ]:


# Ahora es necesario evaluar el modelo. ¿Qué métrica es mejor utilizar en este caso?


# _indica aquí tu respuesta_

# In[ ]:





# In[ ]:


# ¿Qué error tiene el modelo? Explícalo.


# _indica aquí tu respuesta_

# In[ ]:





# Ahora debes entrenar un segundo modelo que haga uso de una regresión lineal múltiple con todas las variables del dataset. Después de entrenar, realiza las predicciones para este segundo modelo.

# In[ ]:





# In[ ]:





# In[ ]:





# ¿Qué error tiene este modelo?¿Es mejor o peor que el anterior?

# _indica aquí tu respuesta_

# In[ ]:





# #### Regresión con árboles de decisión
# 
# A continuación, se requiere hacer dos modelos que usen árboles de decisión para realizar las predicciones.
# 
# Para los árboles de decisión, al ser una tarea de regresión, hay que usar el módulo https://scikit-learn.org/stable/modules/generated/sklearn.tree.DecisionTreeRegressor.html
# 
# El algortimo de DTRegressor necesitar ajustar una serie de hiperparámetros para realizar las predicciones. La implementación de sklearn nos da mucha flexibilidad para nuestros modelos. En general, para los problemas más comunes de regresión, nos tenemos que preocupar de los siguientes hiperparámetros:
# 
# * criterion
# * splitter
# * max_depth
# * min_samples_split
# * min_samples_leaf
# * max_features
# 
# Indica qué son cada uno de estos hiperparámetros
# 
# _indica aquí tu respuesta_
# 
# Además de los hiperparámetros que acabas de descubrir, la implementación de sklearn tiene el hiperparámetro min_impurity_decrease
# 
# ¿Qué indica ese parámetro? ¿Para qué puede ser útil?
# 
# _indica aquí tu respuesta_

# Entrena un modelo de árboles de decisión donde, el criterio para realizar las particiones sea _poisson_, la profundidad máxima de los árboles debe ser 10, el número mínimo de ejemplos para realizar una partición debe ser 10, el número mínimo de ejemplos para considerarlo una hoja debe ser 2, y el número máximo de características deben ser todas.

# In[ ]:





# In[ ]:





# Calcula MAE, R2 y RMSLE

# In[ ]:





# ¿Existe overfitting? Indica qué debes hacer para comprobar si hay overfitting.

# In[ ]:





# ¿Este modelo es mejor, peor o igual que los de regresión lineal simple y múltiple? Razona tu respuesta.

# _indica aquí tu respuesta_

# **Comparativa**
# 
# En base al EDA realizado, a las decisiones tomadas sobre los datos e hiperparámetros y a las características computacionales de tu equipo. ¿Qué modelo obtiene mejores resultados de regresión?

# In[ ]:





# In[ ]:





# ## Investigación
# 
# Buscar un artículo científico (https://scholar.google.es/) con un caso de uso de regresión empleando una de las dos técnicas (o ambas) vistas en la actividad. Los artículos deben estar en revistas científicas, y deben ser posteriores a 2015. No debe utilizar técnicas de Deep Learning.
# 
# _introduce aquí la referencia APA del artículo_
# 
# título, autores, revista, año de publicación
# 
# Objetivo: cuál es el objetivo de la investigación, es decir a qué problema real está aplicando la regresión. Técnicas de regresión empleadas y si realiza alguna adaptación. Principales resultados de la aplicación y de la investigación.

# In[ ]:




