FROM ruby:3.2.0-alpine

# Set environment vars
ENV BUNDLER_VERSION=2.3.26

# Install OS dependencies
RUN apk update && apk add --no-cache \
  build-base \
  postgresql-dev \
  nodejs \
  yarn \
  tzdata \
  bash \
  git

# Set working directory
WORKDIR /app

# Install bundler and configure platform
RUN gem install bundler:$BUNDLER_VERSION && bundle config set force_ruby_platform true

# Copy Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy app code
COPY . .

# Expose Rails port
EXPOSE 3000

# Start Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]