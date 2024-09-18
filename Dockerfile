FROM node:latest
WORKDIR /frontend

COPY package*.json .
RUN npm install && npm cache clean --force

COPY . .
RUN npm run build
