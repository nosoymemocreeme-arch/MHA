FROM node:18-alpine

WORKDIR /app

# Instala herramientas necesarias
RUN apk add --no-cache git curl unzip

# Clona SillyTavern principal
RUN git clone https://github.com/SillyTavern/SillyTavern .

# Instala dependencias con fixes
RUN npm install --no-optional --legacy-peer-deps --force --ignore-scripts

# Descarga WebSearch ZIP desde codeload (endpoint directo) con headers browser + user-agent
RUN curl -L -H "User-Agent: Mozilla/5.0" -o main.zip https://github.com/SillyTavern/SillyTavern-WebSearch/archive/main.zip && \
    ls -l main.zip && \
    file main.zip && \
    unzip -q -o main.zip -d temp && \
    ls -l temp && \
    mv temp/SillyTavern-WebSearch-main extensions/WebSearch && \
    rm -rf temp main.zip
EXPOSE 8000

CMD ["node", "server.js", "--listen", "0.0.0.0", "--port", "8000"]
