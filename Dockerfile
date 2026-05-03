FROM node:18

WORKDIR /app

COPY app/package.json .
COPY app/server.js .

RUN npm install

EXPOSE 3000

CMD ["node", "server.js"]
