import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import StandardScaler

print("--- Iniciando Script 1: Pré-processamento ---")

# Carrega o dataset
try:
    df = pd.read_csv('dataSet/archive/synthetic_coffee_health_10000.csv')
    print("Arquivo 'synthetic_coffee_health_10000.csv' carregado com sucesso!")
except FileNotFoundError:
    print("Erro: O arquivo 'dataSet/archive/synthetic_coffee_health_10000.csv' não foi encontrado.")
    exit()

# Remove colunas irrelevantes
print("Removendo colunas irrelevantes (ID)...")
df = df.drop(columns=['ID'])

# Codificação de variáveis categóricas
print("Codificando variáveis categóricas...")
sleep_quality_mapping = {'Good': 2, 'Fair': 1, 'Poor': 0}
df['Sleep_Quality'] = df['Sleep_Quality'].map(sleep_quality_mapping)

stress_level_mapping = {'Low': 0, 'Medium': 1, 'High': 2}
df['Stress_Level'] = df['Stress_Level'].map(stress_level_mapping)

nominal_cols = ['Gender', 'Country', 'Health_Issues', 'Occupation']
df = pd.get_dummies(df, columns=nominal_cols, drop_first=True)

# Tratamento de valores ausentes
print("Tratando valores ausentes...")
if df.isnull().sum().sum() > 0:
    for col in df.columns:
        if df[col].isnull().any():
            median_val = df[col].median()
            df[col] = df[col].fillna(median_val)
            print(f"Valores ausentes na coluna '{col}' preenchidos com a mediana.")
else:
    print("Não há valores ausentes a serem tratados.")

# Limpeza de dados duplicados
print(f"Formato antes de remover duplicatas: {df.shape}")
df.drop_duplicates(inplace=True)
print(f"Formato após remover duplicatas: {df.shape}")

# Remoção de Outliers
print("Removendo outliers...")
TARGET = 'Stress_Level'
features = [col for col in df.columns if col != TARGET]
numeric_features = df[features].select_dtypes(include=np.number).columns.tolist()

df_sem_outliers = df.copy()
for col in numeric_features:
    q25 = df_sem_outliers[col].quantile(0.25)
    q75 = df_sem_outliers[col].quantile(0.75)
    iqr = q75 - q25
    cut_off = iqr * 1.5
    lower, upper = q25 - cut_off, q75 + cut_off
    df_sem_outliers = df_sem_outliers[(df_sem_outliers[col] >= lower) & (df_sem_outliers[col] <= upper)]

print(f"Formato original: {df.shape}")
print(f"Formato após remover outliers: {df_sem_outliers.shape}")
df = df_sem_outliers

# Normalização dos dados
print("Normalizando os dados...")
scaler = StandardScaler()
df[numeric_features] = scaler.fit_transform(df[numeric_features])

# Salvando o DataFrame Processado
try:
    df.to_csv('dataSet/processed_coffee_data.csv', index=False)
    print("Arquivo 'processed_coffee_data.csv' salvo com sucesso na pasta 'dataSet'.")
except Exception as e:
    print(f"Ocorreu um erro ao salvar o arquivo: {e}")

print("--- Script 1 finalizado ---")
