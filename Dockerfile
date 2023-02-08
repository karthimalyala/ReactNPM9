FROM node:lts-alpine
ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*","sshd_config","init_container.sh", "./"]
RUN npm install --production --silent && mv node_modules ../
COPY sshd_config /etc/ssh/

# Start and enable SSH
RUN apk add openssh \
    && echo "root:Docker!" | chpasswd \
    && chmod +x //usr/src/app/init_container.sh \
    && cd /etc/ssh/ \
    && ssh-keygen -A

COPY . .
EXPOSE 3000 2222
#RUN chown -R node /usr/src/app
#USER node
ENTRYPOINT [ "/usr/src/app/init_container.sh" ]  
