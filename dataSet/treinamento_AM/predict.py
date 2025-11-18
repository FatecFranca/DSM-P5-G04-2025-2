import pandas as pd
import joblib
import numpy as np
import sys
import json

def predict(data):
    """
    Carrega o modelo e o normalizador treinados, pré-processa os dados de entrada
    e retorna a previsão do nível de estresse.
    """
    try:
        # Os caminhos são relativos à raiz do projeto, onde a API será executada
        model = joblib.load('dataSet/modelo_estresse.joblib')
        scaler = joblib.load('dataSet/scaler_estresse.joblib')
    except FileNotFoundError:
        return {"error": "Modelo ou normalizador não encontrado. Garanta que os artefatos estão na pasta 'dataSet/'."}

    # Pega os nomes das colunas diretamente do scaler, garantindo consistência com o treinamento
    x_columns = scaler.feature_names_in_

    # Converte o dicionário de entrada para um DataFrame do Pandas
    novo_usuario_df = pd.DataFrame([data])

    # Pré-processa os dados: aplica One-Hot Encoding e alinha as colunas
    novo_usuario_encoded = pd.get_dummies(novo_usuario_df)
    novo_usuario_aligned = novo_usuario_encoded.reindex(columns=x_columns, fill_value=0)

    # Normaliza os dados com o normalizador carregado
    novo_usuario_scaled = scaler.transform(novo_usuario_aligned)

    # Faz a previsão
    previsao_numerica = model.predict(novo_usuario_scaled)
    probabilidade = model.predict_proba(novo_usuario_scaled)

    # Mapeia a previsão numérica de volta para um texto legível
    stress_map = {0: 'Baixo', 1: 'Médio', 2: 'Alto'}
    previsao_legivel = stress_map.get(previsao_numerica[0], "Desconhecido")

    # Retorna o resultado como um dicionário
    result = {
        "predictedStressLevel": previsao_legivel,
        "confidence": f"{np.max(probabilidade)*100:.2f}%"
    }
    return result

if __name__ == '__main__':
    # O JSON com os dados do usuário é passado como o primeiro argumento da linha de comando
    if len(sys.argv) > 1:
        try:
            # Carrega os dados do argumento
            input_data = json.loads(sys.argv[1])
            # Chama a função de previsão
            prediction_result = predict(input_data)
            # Imprime o resultado como uma string JSON para o stdout (saída padrão)
            print(json.dumps(prediction_result))
        except json.JSONDecodeError:
            print(json.dumps({"error": "JSON inválido fornecido como entrada."}))
        except Exception as e:
            print(json.dumps({"error": f"Ocorreu um erro: {str(e)}"}))
    else:
        print(json.dumps({"error": "Nenhum dado fornecido. Passe os dados do usuário como uma string JSON no argumento."}))
