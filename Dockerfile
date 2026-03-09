FROM node:18-alpine

WORKDIR /app

RUN apk add --no-cache git

RUN git clone https://github.com/SillyTavern/SillyTavern .

RUN npm install --no-optional --legacy-peer-deps --force

RUN git clone https://github.com/SillyTavern/SillyTavern-WebSearch extensions/WebSearch

EXPOSE 8000

CMD ["node", "server.js", "--listen", "0.0.0.0", "--port", "8000"]
