FROM node:18-alpine

WORKDIR /app

# Instala herramientas necesarias
RUN apk add --no-cache git wget unzip

# Clona SillyTavern principal
RUN git clone https://github.com/SillyTavern/SillyTavern .

# Instala dependencias con fixes
RUN npm install --no-optional --legacy-peer-deps --force --ignore-scripts

# Descarga WebSearch ZIP con wget + user-agent (evita rate limit/HTML error)
RUN wget --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" -O main.zip https://github.com/SillyTavern/SillyTavern-WebSearch/archive/refs/heads/main.zip && \
    ls -l main.zip && \
    file main.zip && \
    unzip -q -o main.zip -d temp && \
    ls -l temp && \
    mv temp/SillyTavern-WebSearch-main extensions/WebSearch && \
    rm -rf temp main.zip

EXPOSE 8000

CMD ["node", "server.js", "--listen", "0.0.0.0", "--port", "8000"]
