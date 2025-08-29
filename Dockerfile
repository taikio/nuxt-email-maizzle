# Dockerfile simplificado para desenvolvimento
# POC - Gerador de Templates de E-mail

FROM node:20-alpine

# Define diretório de trabalho
WORKDIR /app

# Instala dependências do sistema necessárias para compilação
RUN apk add --no-cache python3 make g++ libc6-compat

# Copia arquivos de dependências
COPY package*.json ./

# Instala dependências usando npm
RUN npm ci || npm install

# Copia o código da aplicação
COPY . .

# Expõe portas
# 3000 - Aplicação Nuxt
# 24678 - Nuxt DevTools
EXPOSE 3000 24678

# Variáveis de ambiente para desenvolvimento
ENV NODE_ENV=development
ENV NITRO_HOST=0.0.0.0
ENV NITRO_PORT=3000

# Comando para iniciar em modo desenvolvimento com hot reload
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]