import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split, KFold, cross_val_score
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC

print("--- Iniciando Script 2: Treinamento e Avaliação ---")

# Carrega os dados processados
try:
    df = pd.read_csv('processed_coffee_data.csv')
    print("Arquivo 'processed_coffee_data.csv' carregado com sucesso!")
except FileNotFoundError:
    print("Erro: O arquivo 'processed_coffee_data.csv' não foi encontrado.")
    print("Certifique-se de que o script '1_preprocess.py' foi executado com sucesso.")
    exit()

# Preparação dos dados
print("Preparando dados para treinamento...")
TARGET = 'Stress_Level'
features = [col for col in df.columns if col != TARGET]
X = df[features].values
y = df[TARGET].values

validation_size = 0.20
seed = 42
X_train, X_validation, Y_train, Y_validation = train_test_split(X, y, test_size=validation_size, random_state=seed, stratify=y)

# Treinamento e Avaliação dos Modelos
print("Comparando o desempenho de diferentes algoritmos...")
models = []
models.append(('LR', LogisticRegression(solver='liblinear', multi_class='ovr')))
models.append(('LDA', LinearDiscriminantAnalysis()))
models.append(('KNN', KNeighborsClassifier()))
models.append(('CART', DecisionTreeClassifier()))
models.append(('NB', GaussianNB()))
models.append(('SVM', SVC(gamma='auto')))

results_acc = []
results_f1 = []
names = []

for name, model in models:
    kfold = KFold(n_splits=10, shuffle=True, random_state=seed)
    
    # Acurácia
    cv_results_acc = cross_val_score(model, X_train, Y_train, cv=kfold, scoring='accuracy')
    results_acc.append(cv_results_acc)
    
    # F1-Score Ponderado
    cv_results_f1 = cross_val_score(model, X_train, Y_train, cv=kfold, scoring='f1_weighted')
    results_f1.append(cv_results_f1)
    
    names.append(name)
    msg = f"{name}: Acurácia={cv_results_acc.mean():.4f} (std={cv_results_acc.std():.4f}), F1-Score={cv_results_f1.mean():.4f} (std={cv_results_f1.std():.4f})"
    print(msg)

# Visualização e salvamento do gráfico de comparação
print("Gerando e salvando o gráfico de comparação de modelos...")
fig = plt.figure(figsize=(10, 6))
fig.suptitle('Comparação de Algoritmos de Classificação (Acurácia)')
ax = fig.add_subplot(111)
plt.boxplot(results_acc)
ax.set_xticklabels(names)
plt.ylabel('Acurácia')
try:
    plt.savefig('treinamento_AM/model_comparison.png')
    print("Gráfico 'model_comparison.png' salvo em 'dataSet/treinamento_AM/'.")
except Exception as e:
    print(f"Erro ao salvar o gráfico: {e}")


# Análise detalhada do melhor modelo (SVM)
print("\nAnálise detalhada do modelo SVM no conjunto de validação...")
model = SVC(gamma='auto')
model.fit(X_train, Y_train)
predictions = model.predict(X_validation)

print(f"Acurácia no conjunto de validação: {accuracy_score(Y_validation, predictions):.4f}")

print("\nMatriz de Confusão:")
labels = ['Low', 'Medium', 'High']
cm = confusion_matrix(Y_validation, predictions)
print(cm)

print("\nRelatório de Classificação:")
print(classification_report(Y_validation, predictions, target_names=labels))

print("--- Script 2 finalizado ---")
