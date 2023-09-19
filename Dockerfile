FROM node:18.16.0-alpine as builder
ARG HUSKY=0
WORKDIR /usr/src/app
COPY package*.json ./
RUN chown -R node /usr/src
RUN npm ci
COPY . .
RUN npm run build:api
RUN cd .. && mkdir bundle && cp -R app/dist/apps/core/* bundle
WORKDIR /usr/src/bundle
RUN rm -rf /usr/src/app

FROM node:18.16.0-alpine
ARG HUSKY=0
ENV NODE_ENV production
ENV PORT 3003
ENV TZ=Europe/Paris
WORKDIR /usr/src/app
COPY package*.json ./
RUN chown -R node .
RUN npm pkg delete scripts.prepare
RUN npm ci --omit=dev
COPY --from=builder /usr/src/bundle ./dist
CMD [ "node", "dist/main.js" ]
EXPOSE $PORT
