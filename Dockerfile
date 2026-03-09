FROM node:18-alpine

WORKDIR /app

RUN apk add --no-cache git curl unzip

RUN git clone https://github.com/SillyTavern/SillyTavern .

RUN npm install --no-optional --legacy-peer-deps --force

# Para WebSearch, usa curl + unzip en lugar de git clone (evita auth)
RUN curl -L -o main.zip https://github.com/SillyTavern/SillyTavern-WebSearch/archive/refs/heads/main.zip && \
    unzip -o main.zip && \
    mv SillyTavern-WebSearch-main extensions/WebSearch && \
    rm -rf SillyTavern-WebSearch-main main.zip

EXPOSE 8000

CMD ["node", "server.js", "--listen", "0.0.0.0", "--port", "8000"]
