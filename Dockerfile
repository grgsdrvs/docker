FROM node

ENV MONGO_DB_USERNAME=admin \
    MONGO_DB_PWD=password

# executes in the container
RUN mkdir -p /home/app

# executes on the host
COPY ./app /home/app

# set default dir so that next commands executes in /home/app dir
WORKDIR /home/app

# will execute npm install in /home/app because of WORKDIR
RUN npm install

# no need for /home/app/server.js because of WORKDIR. entrypoint command
CMD ["node", "server.js"]

