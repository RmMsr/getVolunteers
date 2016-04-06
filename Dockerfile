FROM ruby:2.3.0-alpine
MAINTAINER Roman Messer <rms@gotocloud.net>
WORKDIR /var/www
EXPOSE 80

# Update system
RUN apk update && apk upgrade

# Install dependencies and gems with cleanup
COPY Gemfile* ./
RUN apk add build-base sqlite-dev \
    && bundle install \
    && apk del build-base \
    && rm -rf /var/cache/apk/*

# Copy and run app
COPY . ./
ENTRYPOINT ["bin/get-volunteers"]
CMD ["--environment=production", "--host=0.0.0.0", "--port=80"]
