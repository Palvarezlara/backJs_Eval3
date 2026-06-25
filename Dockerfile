FROM node:18-alpine

WORKDIR /app

RUN apk add --no-cache curl

COPY package*.json ./
RUN npm ci --only=production

COPY server.js .

EXPOSE 8081

CMD ["node", "server.js"]
