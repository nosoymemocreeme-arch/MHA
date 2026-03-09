FROM node:20-alpine

WORKDIR /app

# Instala git (necesario para clone)
RUN apk add --no-cache git

# Clona SillyTavern principal
RUN git clone https://github.com/SillyTavern/SillyTavern .

# Instala dependencias con fixes rápidos
RUN npm install --no-optional --legacy-peer-deps --force --ignore-scripts --production

EXPOSE 8000

CMD ["node", "server.js", "--listen", "0.0.0.0", "--port", "8000"]
