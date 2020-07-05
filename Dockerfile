FROM node:10.15.2-alpine as builder
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package* ./
COPY tsconfig.json ./
COPY src/ src/
RUN npm install
RUN npm run build:prod

CMD [ "npm", "run", "start:prod" ]

EXPOSE 4000