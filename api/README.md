# API CafeZen

API RESTful para o projeto CafeZen, responsável pelo gerenciamento de usuários, autenticação e coleta de dados de saúde e consumo de café.

---

## Tecnologias Utilizadas

- **Runtime:** Node.js
- **Framework:** Express.js
- **Banco de Dados:** MySQL
- **ORM:** Sequelize
- **Autenticação:** JSON Web Tokens (JWT)
- **Containerização:** Docker & Docker Compose

---

## Como Executar a Aplicação

Existem dois métodos para executar a API. O método com Docker Compose é o mais recomendado por sua simplicidade.

### Método 1: Docker Compose (Recomendado)

Este método orquestra a API e o banco de dados em contêineres, sem a necessidade de instalar o Node.js ou o MySQL na sua máquina.

**Pré-requisitos:**
- Git
- Docker
- Docker Compose

**Passos:**

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/FatecFranca/DSM-P5-G04-2025-2.git
    ```

2.  **Navegue até a pasta do projeto:**
    ```bash
    cd DSM-P5-G04-2025-2
    ```

3.  **Inicie os contêineres:**
    ```bash
    sudo docker-compose up --build
    ```

A API estará disponível em `http://localhost`.

---

### Método 2: Manualmente (Para Desenvolvimento)

Este método é para desenvolvedores que desejam rodar a aplicação diretamente na máquina, sem o isolamento dos contêineres.

**Pré-requisitos:**
- Git
- Node.js (v18 ou superior)
- Servidor MySQL

**Passos:**

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/FatecFranca/DSM-P5-G04-2025-2.git
    ```

2.  **Navegue até a pasta da API:**
    ```bash
    cd DSM-P5-G04-2025-2/api
    ```

3.  **Instale as dependências (dentro da pasta `api`):
    ```bash
    npm install
    ```

4.  **Configure o Banco de Dados:**
    - Certifique-se de que seu servidor MySQL esteja rodando.
    - Crie o banco de dados e o usuário que a aplicação usará. Exemplo:
      ```sql
      CREATE DATABASE cafezen;
      CREATE USER 'seu_usuario'@'localhost' IDENTIFIED BY 'sua_senha';
      GRANT ALL PRIVILEGES ON cafezen.* TO 'seu_usuario'@'localhost';
      FLUSH PRIVILEGES;
      ```

5.  **Configure as Variáveis de Ambiente:**
    - Na **raiz do projeto** (um nível acima da pasta `api`), copie o arquivo de exemplo `.env.example` para um novo arquivo chamado `.env`.
    - Edite o arquivo `.env` com as suas credenciais do banco de dados e uma chave secreta para o JWT.

6.  **Inicie a API (de dentro da pasta `api`):
    ```bash
    npm run dev
    ```

A API estará disponível em `http://localhost:80` (ou a porta configurada no seu `.env`).

---

## Documentação dos Endpoints

Para uma descrição detalhada de todos os endpoints disponíveis, métodos, parâmetros e exemplos de resposta, consulte o arquivo [API_DOCUMENTATION.md](API_DOCUMENTATION.md).
