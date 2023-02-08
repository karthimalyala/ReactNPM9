FROM node:lts-alpine
ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install -g npm@7.21.1
RUN npm install --production --silent && mv node_modules ../

COPY . .
EXPOSE 3000 2222

CMD [ "npm", "run", "start" ]
