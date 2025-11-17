import pandas as pd
import joblib
from sklearn.svm import SVC
from sklearn.preprocessing import StandardScaler
import numpy as np

print("--- Iniciando Script 3: Salvando Modelo Final ---")

# Carrega os dados processados
try:
    df = pd.read_csv('processed_coffee_data.csv')
    print("Arquivo 'processed_coffee_data.csv' carregado com sucesso!")
except FileNotFoundError:
    print("Erro: O arquivo 'processed_coffee_data.csv' não foi encontrado.")
    print("Certifique-se de que o script '1_preprocess.py' foi executado com sucesso.")
    exit()

# Preparação dos dados e treinamento do Normalizador
print("Preparando dados e treinando o normalizador final...")
TARGET = 'Stress_Level'
features = [col for col in df.columns if col != TARGET]
X = df[features]
y = df[TARGET]

scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)
print("Normalizador treinado com o dataset completo.")

# Treinamento do Modelo Final
print("Treinando o modelo final (SVM) com o dataset completo...")
model = SVC(gamma='auto', probability=True)
model.fit(X_scaled, y)
print("Modelo final treinado com sucesso.")

# Salvando os Artefatos
model_path = 'modelo_estresse.joblib'
scaler_path = 'scaler_estresse.joblib'

print(f"Salvando o modelo em: {model_path}")
joblib.dump(model, model_path)
print("Modelo salvo.")

print(f"Salvando o normalizador em: {scaler_path}")
joblib.dump(scaler, scaler_path)
print("Normalizador salvo.")

# Verificação e Exemplo de Uso
print("\n--- Verificação e Exemplo de Uso ---")
try:
    loaded_model = joblib.load(model_path)
    loaded_scaler = joblib.load(scaler_path)
    print("Artefatos carregados para verificação.")

    # Exemplo de um novo usuário
    novo_usuario = {
        'Age': 35, 'Coffee_Intake': 4, 'Caffeine_mg': 380, 'Sleep_Hours': 6.5,
        'Sleep_Quality': 1, 'BMI': 23.5, 'Heart_Rate': 75, 'Physical_Activity_Hours': 2.5,
        'Smoking': 0, 'Alcohol_Consumption': 1, 'Gender': 'Male', 'Country': 'Brazil',
        'Health_Issues': 'None', 'Occupation': 'Office'
    }

    # Preparação dos dados do novo usuário
    novo_usuario_df = pd.DataFrame([novo_usuario])
    novo_usuario_encoded = pd.get_dummies(novo_usuario_df)
    # Usa as colunas do dataframe original (X) para alinhar
    novo_usuario_aligned = novo_usuario_encoded.reindex(columns=X.columns, fill_value=0)

    # Normalização
    novo_usuario_scaled = loaded_scaler.transform(novo_usuario_aligned)

    # Previsão
    previsao = loaded_model.predict(novo_usuario_scaled)
    probabilidade = loaded_model.predict_proba(novo_usuario_scaled)
    stress_map = {0: 'Baixo', 1: 'Médio', 2: 'Alto'}

    print(f"--> Previsão do Nível de Estresse para o usuário de exemplo: {stress_map[previsao[0]]}")
    print(f"Confiança da previsão: {np.max(probabilidade)*100:.2f}%")

except Exception as e:
    print(f"Ocorreu um erro durante a verificação: {e}")


print("--- Script 3 finalizado ---")
