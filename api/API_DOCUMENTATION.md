# Documentação da API - CafeZen

Este documento detalha os endpoints disponíveis na API do projeto CafeZen.

**URL Base:** `http://20.150.192.36`

---

## Autenticação

A autenticação é feita via JSON Web Token (JWT). Para acessar rotas protegidas, é necessário primeiro obter um token através do endpoint de login e, em seguida, enviar este token no cabeçalho de cada requisição. Veja o item 2.1, abaixo, para verificar o funcionamento do endpoint de login para obtenção
do token de autenticação.

- **Header:** `Authorization`
- **Valor:** `Bearer <seu_token_jwt>`

---

## 1. Usuários

Endpoints para o gerenciamento de usuários.

### 1.1 Criar Usuário

- **Método:** `POST`
- **Endpoint:** `/usuarios`
- **Descrição:** Cria um novo usuário no sistema.
- **Autenticação:** Pública.

**Corpo da Requisição (Body):**
```json
{
    "Nome": "Nome do Usuário",
    "CPF": "123.456.789-00",
    "E-mail": "usuario@email.com",
    "Senha": "senhaforte123",
    "Cep": "12345-678",
    "data_nasc": "YYYY-MM-DD"
}
```

**Resposta de Sucesso (201 Created):**
```json
{
    "Id_usuario": 1,
    "Nome": "Nome do Usuário",
    "CPF": "123.456.789-00",
    "E-mail": "usuario@email.com",
    "Cep": "12345-678",
    "data_nasc": "YYYY-MM-DD"
}
```

### 1.2 Listar Todos os Usuários

- **Método:** `GET`
- **Endpoint:** `/usuarios`
- **Descrição:** Retorna uma lista com todos os usuários cadastrados.
- **Autenticação:** Protegida por JWT.

**Resposta de Sucesso (200 OK):**
```json
[
    {
        "Id_usuario": 1,
        "Nome": "Usuário Um",
        "CPF": "111.111.111-11",
        "E-mail": "um@email.com",
        "Cep": "11111-111",
        "data_nasc": "1990-01-01"
    },
    {
        "Id_usuario": 2,
        "Nome": "Usuário Dois",
        "CPF": "222.222.222-22",
        "E-mail": "dois@email.com",
        "Cep": "22222-222",
        "data_nasc": "1992-02-02"
    }
]
```

### 1.3 Buscar Usuário por ID

- **Método:** `GET`
- **Endpoint:** `/usuarios/:id`
- **Descrição:** Retorna os dados de um usuário específico.
- **Autenticação:** Protegida por JWT.

**Resposta de Sucesso (200 OK):**
```json
{
    "Id_usuario": 1,
    "Nome": "Usuário Um",
    "CPF": "111.111.111-11",
    "E-mail": "um@email.com",
    "Cep": "11111-111",
    "data_nasc": "1990-01-01"
}
```

### 1.4 Atualizar Usuário

- **Método:** `PUT`
- **Endpoint:** `/usuarios/:id`
- **Descrição:** Atualiza os dados de um usuário específico. Apenas os campos enviados no corpo serão atualizados.
- **Autenticação:** Protegida por JWT. O usuário só pode atualizar o seu próprio perfil (o ID do token deve ser o mesmo do ID da URL).

**Corpo da Requisição (Body):**
```json
{
    "Nome": "Novo Nome do Usuário",
    "Senha": "novasenha123"
}
```

**Resposta de Sucesso (200 OK):**
```json
{
    "Id_usuario": 1,
    "Nome": "Novo Nome do Usuário",
    "CPF": "111.111.111-11",
    "E-mail": "um@email.com",
    "Cep": "11111-111",
    "data_nasc": "1990-01-01"
}
```

### 1.5 Deletar Usuário

- **Método:** `DELETE`
- **Endpoint:** `/usuarios/:id`
- **Descrição:** Deleta um usuário específico.
- **Autenticação:** Protegida por JWT. O usuário só pode deletar o seu próprio perfil (o ID do token deve ser o mesmo do ID da URL).

**Resposta de Sucesso (200 OK):**
```json
{
    "message": "Usuário deletado com sucesso"
}
```

---

## 2. Autenticação

Endpoint para autenticar um usuário e receber um token de acesso.

### 2.1 Login

- **Método:** `POST`
- **Endpoint:** `/login`
- **Descrição:** Autentica um usuário com e-mail e senha e retorna um token JWT.
- **Autenticação:** Pública.

**Corpo da Requisição (Body):**
```json
{
    "E-mail": "usuario@email.com",
    "Senha": "senhaforte123"
}
```

**Resposta de Sucesso (200 OK):**
```json
{
    "message": "Login bem-sucedido",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

---

## 3. Formulários de Saúde

Endpoints para o gerenciamento dos formulários de saúde.

### 3.1 Criar Formulário

- **Método:** `POST`
- **Endpoint:** `/forms`
- **Descrição:** Cria um novo formulário de saúde para o usuário autenticado.
- **Autenticação:** **Protegida por JWT.**

**Corpo da Requisição (Body):**
```json
{
    "Idade": 33,
    "Genero": "Masculino",
    "Pais": "Brasil",
    "xicarasDiaCafe": 3,
    "cafeinaEstimada": 250,
    "horasSono": 7,
    "qualidadeDeSono": 8,
    "IMC": 24.5,
    "frequenciaCardio": 65,
    "problemasDeSaude": "Nenhum",
    "atvFisicaSemanalHrs": 5,
    "Ocupacao": "Desenvolvedor",
    "Fuma": "Não",
    "Alcool": "Socialmente"
}
```

**Resposta de Sucesso (201 Created):**
```json
{
    "Id_form": 1,
    "Id_usuario": 1,
    "Idade": 33,
    "Genero": "Masculino",
    "Pais": "Brasil",
    "xicarasDiaCafe": 3,
    "cafeinaEstimada": 250,
    "horasSono": 7,
    "qualidadeDeSono": 8,
    "IMC": 24.5,
    "frequenciaCardio": 65,
    "problemasDeSaude": "Nenhum",
    "atvFisicaSemanalHrs": 5,
    "Ocupacao": "Desenvolvedor",
    "Fuma": "Não",
    "Alcool": "Socialmente"
}
```

### 3.2 Buscar Formulário

- **Método:** `GET`
- **Endpoint:** `/forms`
- **Descrição:** Busca o formulário de saúde preenchido pelo usuário autenticado.
- **Autenticação:** **Protegida por JWT.**

**Resposta de Sucesso (200 OK):**
```json
{
    "Id_form": 1,
    "Id_usuario": 1,
    "Idade": 33,
    "Genero": "Masculino",
    "Pais": "Brasil",
    "xicarasDiaCafe": 3,
    "cafeinaEstimada": 250,
    "horasSono": 7,
    "qualidadeDeSono": 8,
    "IMC": 24.5,
    "frequenciaCardio": 65,
    "problemasDeSaude": "Nenhum",
    "atvFisicaSemanalHrs": 5,
    "Ocupacao": "Desenvolvedor",
    "Fuma": "Não",
    "Alcool": "Socialmente"
}
```

**Resposta de Erro (404 Not Found):**
```json
{
    "error": "Formulário não encontrado"
}
```

### 3.3 Atualizar Formulário

- **Método:** `PUT`
- **Endpoint:** `/forms`
- **Descrição:** Atualiza o formulário de saúde do usuário autenticado. Apenas os campos enviados no corpo da requisição serão atualizados.
- **Autenticação:** **Protegida por JWT.**

**Corpo da Requisição (Body):**
```json
{
    "xicarasDiaCafe": 4,
    "qualidadeDeSono": 7
}
```

**Resposta de Sucesso (200 OK):**
```json
{
    "Id_form": 1,
    "Id_usuario": 1,
    "Idade": 33,
    "Genero": "Masculino",
    "Pais": "Brasil",
    "xicarasDiaCafe": 4,
    "cafeinaEstimada": 250,
    "horasSono": 7,
    "qualidadeDeSono": 7,
    "IMC": 24.5,
    "frequenciaCardio": 65,
    "problemasDeSaude": "Nenhum",
    "atvFisicaSemanalHrs": 5,
    "Ocupacao": "Desenvolvedor",
    "Fuma": "Não",
    "Alcool": "Socialmente"
}
```
