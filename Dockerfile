FROM ruby:2.6.3


ENV HOME=/opt/app
WORKDIR $HOME



#install phoenix dependenices
RUN gem install rails -v '6.0.2'
RUN gem install bundler
RUN   apt-get -y install curl gnupg
RUN  curl -sL https://deb.nodesource.com/setup_12.x  | bash -
RUN apt-get -y install nodejs
RUN npm install -g yarn
RUN  npm install -g webpack
RUN apt-get update

COPY . .

RUN bundle 
RUN yarn install 



EXPOSE 3000
RUN chmod +x ./entry.sh
ENTRYPOINT [ "./entry.sh" ]




