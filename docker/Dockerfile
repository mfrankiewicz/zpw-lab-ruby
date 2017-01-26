FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /app
WORKDIR /app

COPY ./start.sh /start.sh

EXPOSE 80
CMD [ "bash", "/start.sh" ]
