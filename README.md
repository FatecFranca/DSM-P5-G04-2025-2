# CaféZen: Equilíbrio entre Energia e Bem-Estar

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

> Para mais detalhes sobre a execução e os endpoints, consulte o **[README da API](./api/README.md)** e a **[Documentação dos Endpoints](./api/API_DOCUMENTATION.md)**.

### 2. Frontend (Aplicativo Mobile)

O aplicativo, desenvolvido com Flutter, oferece uma interface amigável para que o usuário final possa:
- Criar uma conta e fazer login.
- Preencher formulários sobre seus hábitos de vida e consumo de café.
- Visualizar o resultado da análise de estresse.
- Receber recomendações personalizadas.

> Para mais detalhes, consulte o diretório **[`/front`](./front/)**.

### 3. Inteligência Artificial (Machine Learning)

O coração do CaféZen é um modelo de classificação que prevê o nível de estresse do usuário (Baixo, Médio ou Alto) com base em seus hábitos.
- **Algoritmo:** *Support Vector Machine* (SVM).
- **Processo:** O backend Node.js invoca um script Python (`predict.py`) para realizar a inferência em tempo real.

> Para entender o processo de treinamento, os dados utilizados e como o modelo é integrado à API, consulte o **[README do Modelo de ML](./dataSet/README.md)**.

## Links Úteis

- [Figma (Design da Interface)](https://www.figma.com/files/team/1304939508932388540/recents-and-sharing?fuid=1291172194950882839)
- [Lucidspark (Modelagem do Banco de Dados)](https://lucid.app/lucidspark/e7976b5d-5e38-4193-ba40-691f051227fb/edit?viewport_loc=-19669%2C-7834%2C18758%2C8225%2C0_0&invitationId=inv_8e559200-d469-4597-8833-9bd30634af7c)

## Integrantes

- Danilo Benedette
- Gustavo Santos
- Thiago Resende
- Wilton Monteiro

---

*Repositório do GRUPO 04 para o Projeto Interdisciplinar do 5º semestre do curso de Desenvolvimento de Software Multiplataforma (DSM) - 2025/2.*
