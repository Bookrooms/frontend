FROM node:latest
WORKDIR /app

COPY package*.json .
RUN npm i

COPY . .
RUN npm run build

ENTRYPOINT [ "./docker-entrypoint.sh" ]
