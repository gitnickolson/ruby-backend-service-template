# Guess Anything API

## Basic Setup

Set up database
```
ENV=db bundle exec rake db:create db:migrate
```
(It can be dropped by running db:drop if you need to clean something up)

Run rubocop
```
bundle exec rubocop -a
```
Run with the -A flag if you want it to autocorrect things if possible

Run all tests
```
bundle exec rspec
```

Run rubocop and all tests
```
bundle exec rake
```