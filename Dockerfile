FROM ruby:3.0.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /rootly-1
COPY Gemfile /rootly-1/Gemfile
COPY Gemfile.lock /rootly-1/Gemfile.lock
RUN bundle install && rails tailwindcss:install
COPY . /rootly-1

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

RUN chmod +x bin/dev

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]