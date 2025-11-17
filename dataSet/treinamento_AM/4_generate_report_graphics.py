import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

print("--- Iniciando Script 4: Geração de Gráficos para o Relatório ---")

# 1. Gráfico de Pizza da Distribuição das Classes
print("Gerando gráfico de distribuição das classes...")
try:
    df = pd.read_csv('processed_coffee_data.csv')
    class_counts = df['Stress_Level'].value_counts()
    class_labels = {0: 'Baixo', 1: 'Médio', 2: 'Alto'}
    labels = class_counts.index.map(class_labels)

    plt.figure(figsize=(8, 8))
    plt.pie(class_counts, labels=labels, autopct='%1.1f%%', startangle=140, colors=['#66b3ff','#99ff99','#ffcc99'])
    plt.title('Distribuição das Classes de Nível de Estresse')
    plt.ylabel('') # Esconde o label do eixo y
    pie_path = 'treinamento_AM/class_distribution.png'
    plt.savefig(pie_path)
    print(f"Gráfico de distribuição salvo em: {pie_path}")
    plt.close()

except FileNotFoundError:
    print("Erro: O arquivo 'processed_coffee_data.csv' não foi encontrado.")
    print("Certifique-se de que o script '1_preprocess.py' foi executado com sucesso.")
except Exception as e:
    print(f"Ocorreu um erro ao gerar o gráfico de pizza: {e}")


# 2. Heatmap da Matriz de Confusão
print("\nGerando heatmap da matriz de confusão...")
try:
    # Valores obtidos da execução do script 2_train.py
    cm_data = np.array([[1100, 0, 0],
                        [0, 324, 0],
                        [0, 150, 0]])
    
    labels = ['Baixo', 'Médio', 'Alto']
    
    plt.figure(figsize=(8, 6))
    sns.heatmap(cm_data, annot=True, fmt='d', cmap='Blues', xticklabels=labels, yticklabels=labels)
    plt.title('Matriz de Confusão do Modelo SVM')
    plt.xlabel('Rótulo Previsto')
    plt.ylabel('Rótulo Verdadeiro')
    
    cm_path = 'treinamento_AM/confusion_matrix.png'
    plt.savefig(cm_path)
    print(f"Heatmap da matriz de confusão salvo em: {cm_path}")
    plt.close()

except Exception as e:
    print(f"Ocorreu um erro ao gerar o heatmap: {e}")

print("\n--- Script 4 finalizado ---")
