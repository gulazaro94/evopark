# README

Requirements

- Ruby 2.7.1
- Docker & Docker compose

## Steps to run the project in development mode

Clone the repo
```
git clone git@github.com:gulazaro94/evopark.git
cd evopark
```

Install the dependencies
```
bundle install
yarn install
```

Start redis and mailcatcher
```
docker-compose up -d
```

Setup the database
```
bundle exec rails db:setup
```

Start sidekiq
```
bundle exec sidekiq
```
This will hold the terminal, open a new tab to continue


Start the Rails server
```
bundle exec rails s -b 0.0.0.0
```

## Links

Application

http://localhost:3000

Sidekiq

http://localhost:3000/sidekiq

Mailcatcher

http://localhost:1080
