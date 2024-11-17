FROM ruby:3.1

RUN gem install bundler
RUN apt-get update && apt-get install -y iputils-ping

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["ruby", "script.rb"]
