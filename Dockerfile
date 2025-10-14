# Use uma imagem Node.js oficial e leve
FROM node:18-alpine

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia os arquivos de dependência de DENTRO da pasta api
COPY api/package.json api/package-lock.json ./

# Instale apenas as dependências de produção
RUN npm ci --only=production

# Copie o restante do código da API para o diretório de trabalho
COPY api/ .

# Exponha a porta em que a aplicação roda
EXPOSE 80

# Crie um usuário não-root para rodar a aplicação por segurança
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Comando para iniciar a aplicação (o ponto de entrada agora é a raiz do /app)
CMD ["node", "index.js"]