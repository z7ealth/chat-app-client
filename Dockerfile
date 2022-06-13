FROM node:15-alpine AS ts-build

WORKDIR /app

COPY . .

RUN npm install && \
npm run build

FROM node:15-alpine AS ts-run-prod

WORKDIR /app

COPY --from=ts-build ./app/build ./build

COPY package* ./

RUN npm install --production && \
    npm install -g serve

EXPOSE 3000

CMD serve -s build > chat-app-client.out
