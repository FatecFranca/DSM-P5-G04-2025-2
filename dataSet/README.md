# Modelo de Classificação de Nível de Estresse

Este diretório contém os scripts e os artefatos para um modelo de Machine Learning que prevê o nível de estresse de um usuário com base em seus hábitos de consumo de café e estilo de vida.

## Objetivo do Modelo

O objetivo é classificar o nível de estresse de um usuário em uma de três categorias: **Baixo**, **Médio** ou **Alto**, a partir de dados fornecidos pelo `synthetic_coffee_health_10000.csv`.

## Pipeline de Treinamento (Scripts Python)

O processo de criação do modelo segue um pipeline de Descoberta de Conhecimento em Bases de Dados (KDD), garantindo robustez e rastreabilidade. Os scripts estão localizados na pasta `treinamento_AM/` e devem ser executados na seguinte ordem:

1.  **`1_preprocess.py`**: Carrega o dataset bruto, realiza a limpeza (tratamento de NaNs, remoção de duplicatas e outliers) e o pré-processamento, que inclui a codificação de variáveis categóricas e a normalização com `StandardScaler`.
2.  **`2_train.py`**: Carrega os dados processados, treina e compara diferentes algoritmos de classificação (incluindo SVM, Random Forest e Regressão Logística) para identificar o de melhor performance.
3.  **`3_save_model.py`**: Seleciona o melhor modelo (SVM), treina-o com o conjunto de dados completo e salva os artefatos finais (`.joblib`).

## Resultados e Modelo Escolhido

Conforme documentado no **Relatório Técnico Final**, foram comparados múltiplos algoritmos de classificação. O modelo **Support Vector Machine (SVM)** foi o escolhido, pois demonstrou performance superior.

### Comparação de Desempenho

A tabela abaixo resume a performance dos principais modelos avaliados no conjunto de teste:

| Modelo Candidato | Acurácia (Teste) | F1-Score (Ponderado) | Observações |
| :--- | :--- | :--- | :--- |
| **SVM (Support Vector Machine)** | **1.00** | **1.00** | **Desempenho perfeito. Escolhido como modelo final.** |
| Random Forest | 0.98 | 0.97 | Geralmente robusto, mas não atingiu a separação perfeita. |
| Regressão Logística | 0.85 | 0.84 | Desempenho aceitável, mas inferior aos demais. |

### Justificativa da Escolha do SVM

O SVM alcançou **100% de acurácia, precisão, recall e F1-Score** para todas as classes (Baixo, Médio e Alto) no conjunto de teste. Esse desempenho perfeito, validado pela matriz de confusão sem erros de classificação, indica que o modelo é extremamente eficaz para o dataset sintético utilizado. Além de seu desempenho, o SVM foi escolhido por sua robustez teórica, como a maximização de margem, que favorece a generalização.

## Artefatos Finais

Os seguintes arquivos foram gerados e são os únicos necessários para usar o modelo em produção. O modelo escolhido foi o **SVM**, devido à sua performance perfeita documentada no relatório técnico.

*   **`modelo_estresse.joblib`**: O modelo de classificação (SVM) treinado.
*   **`scaler_estresse.joblib`**: O objeto `StandardScaler` (normalizador) treinado. **É essencial para a predição, pois os dados de entrada devem ser normalizados da mesma forma que os dados de treinamento.**

---

## Guia de Integração (Backend Node.js)

Para usar o modelo, a API backend (Node.js) deve invocar o script `predict.py`, que carrega os artefatos e executa a previsão.

### 1. Script de Previsão (`predict.py`)

Este script recebe os dados de um usuário como um argumento JSON na linha de comando, carrega o `scaler` e o `model`, realiza a predição e imprime o resultado em formato JSON.

### 2. Exemplo de Controller em Node.js

Abaixo, um exemplo de como a API Node.js pode chamar o script `predict.py` usando `child_process`.

```javascript
// Exemplo: predictController.js
const { spawn } = require('child_process');

const predictStressLevel = (req, res) => {
    // 1. Obter os dados do usuário do corpo da requisição
    const userData = req.body;

    // Converte o objeto de dados do usuário em uma string JSON
    const userDataString = JSON.stringify(userData);

    // 2. Chamar o script Python como um processo filho
    const pythonProcess = spawn('python3', [
        'dataSet/treinamento_AM/predict.py',
        userDataString
    ]);

    let predictionResult = '';
    let errorData = '';

    // 3. Capturar a saída do script Python
    pythonProcess.stdout.on('data', (data) => {
        predictionResult += data.toString();
    });

    // Capturar qualquer erro do script
    pythonProcess.stderr.on('data', (data) => {
        errorData += data.toString();
    });

    // 4. Enviar a resposta quando o script terminar
    pythonProcess.on('close', (code) => {
        if (code !== 0 || errorData) {
            console.error(`Python script exited with code ${code}`);
            console.error('Error data:', errorData);
            return res.status(500).json({ 
                message: "Erro ao processar a previsão.",
                error: errorData 
            });
        }

        try {
            const result = JSON.parse(predictionResult);
            if (result.error) {
                 return res.status(400).json({ message: result.error });
            }
            // Envia o resultado da previsão de volta para o frontend
            return res.status(200).json(result);
        } catch (e) {
            return res.status(500).json({ 
                message: "Erro ao parsear o resultado da previsão.",
                rawOutput: predictionResult 
            });
        }
    });
};

module.exports = {
    predictStressLevel,
};
```