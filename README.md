# CaféZen: Equilíbrio entre Energia e Bem-Estar

<img width="502" height="402" alt="image" src="https://github.com/user-attachments/assets/5627431a-4b7f-4dde-8afb-e5d54a4150aa" />

## Sobre o Projeto

O **CaféZen** é uma ferramenta completa, desenvolvida para ajudar pessoas a encontrarem um equilíbrio saudável entre o consumo de café e o bem-estar em meio a uma rotina acelerada. A solução integra um aplicativo mobile, uma API de backend e um modelo de inteligência artificial para fornecer recomendações personalizadas.

Nossa missão é oferecer uma forma simples e prática para que os usuários possam:

- **Monitorar seus hábitos:** Acompanhar o consumo de café e outros fatores de bem-estar através de um aplicativo intuitivo.
- **Avaliar o nível de estresse:** O aplicativo utiliza um modelo de Machine Learning para prever o nível de estresse do usuário com base nos dados fornecidos.
- **Receber recomendações:** Com base na previsão, o CaféZen indica o consumo ideal de café para promover saúde e produtividade de forma sustentável.

## Arquitetura e Tecnologias

O projeto é construído sobre uma arquitetura de microsserviços, utilizando tecnologias modernas para cada componente.

| Componente | Tecnologia | Descrição |
| :--- | :--- | :--- |
| **Frontend** | `Flutter` | Aplicativo mobile multiplataforma (Android/iOS) para interação com o usuário. |
| **Backend** | `Node.js`, `Express.js` | API RESTful para gerenciar usuários, dados e autenticação. |
| **Banco de Dados** | `MySQL` com `Sequelize` | Armazenamento de dados relacionais de usuários e formulários. |
| **Machine Learning** | `Python`, `Scikit-learn` | Modelo de classificação (SVM) para prever o nível de estresse. |
| **Containerização** | `Docker`, `Docker Compose` | Orquestração dos serviços de backend e banco de dados para fácil execução. |

## Estrutura do Projeto

O repositório está organizado nos seguintes diretórios principais:

- **`/api`**: Contém todo o código-fonte do backend (API RESTful em Node.js).
- **`/front`**: Contém o código-fonte do aplicativo mobile desenvolvido em Flutter.
- **`/dataSet`**: Inclui os scripts de treinamento do modelo de Machine Learning, os artefatos do modelo (`.joblib`) e a documentação de integração.
- **`/UI_UX`**: Artefatos de design e identidade visual do projeto.

## Como Executar o Projeto (Ambiente Completo)

O método mais simples para executar o ambiente de backend é utilizando Docker e Docker Compose, que orquestram a API e o banco de dados.

**Pré-requisitos:**
- Git
- Docker
- Docker Compose

**Passos:**

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/FatecFranca/DSM-P5-G04-2025-2.git
    cd DSM-P5-G04-2025-2
    ```

2.  **Configure as Variáveis de Ambiente:**
    - Copie o arquivo de exemplo `.env.example` para um novo arquivo chamado `.env`.
    - Edite o arquivo `.env` se precisar alterar portas ou credenciais (os padrões já funcionam com o Docker Compose).

3.  **Inicie os contêineres:**
    ```bash
    sudo docker-compose up --build
    ```
A API estará disponível em `http://localhost` (ou na porta que você configurar). Para o frontend, siga as instruções no README do diretório `/front`.

## Detalhes dos Componentes

### 1. Backend (API)

A API, construída em Node.js, é o cérebro do sistema, responsável por:
- Gerenciamento de usuários (cadastro e login).
- Autenticação via JWT (JSON Web Tokens).
- Coleta e armazenamento de dados dos formulários.
- Comunicação com o modelo de Machine Learning para obter previsões.

> Para mais detalhes sobre a API, consulte o README no diretório [`/api`](./api).

### 2. Frontend (Aplicativo Mobile)

O aplicativo mobile, desenvolvido em Flutter, oferece uma interface amigável para que o usuário possa:
- Realizar login e cadastro.
- Preencher o formulário de hábitos de vida.
- Visualizar o resultado da previsão de estresse.

> O README no diretório [`/front`](./front) contém mais informações sobre como executar e testar o aplicativo.

### 3. Inteligência Artificial (Modelo de Classificação)

O modelo de Machine Learning é responsável por analisar os dados do usuário e classificar seu nível de estresse.

- **Localização:** O pipeline de treinamento e o script de previsão estão no diretório [`/dataSet`](./dataSet).
- **Modelo:** Foi escolhido um **Support Vector Machine (SVM)**, que alcançou 100% de acurácia no conjunto de dados de teste.
- **Integração:** A API Node.js chama um script Python (`predict.py`) para obter as previsões em tempo real.

> O README no diretório [`/dataSet`](./dataSet) oferece uma explicação aprofundada sobre o treinamento, avaliação e integração do modelo.

## Equipe

| Integrante |
| Danilo Benedetti |
| Gustavo Santos |
| Thiago Resende |
| Willton Monteiro |

---
*Repositório do GRUPO 04 para o Projeto Interdisciplinar do 5º semestre do curso de Desenvolvimento de Software Multiplataforma (DSM) - 2025/2.*
