# Ruby Backend Service Template

This is a WIP template that can be used to create a simple backend service in ruby.
It was just recently repurposed, so some things may still need cleanup. It's generally not
finished yet, but you can already use it and it should be functional. 

The service currently supports a simple `User` entity that can have a hashed password (with salt and pepper as well).
I will probably add some more security measurements to this template in the future.

## Basic Setup

### Set up a docker container
```
docker compose up -d
```

### Set up database
Make sure that your `.env` files are correctly configured for what you need and want.

```
# db creation
ENV=db bundle exec rake db:create 

# db migration
ENV=db bundle exec rake db:migrate

# or both
ENV=db bundle exec rake db:create db:migrate
```
(It can be dropped by running db:drop if you need to clean something up)

### Run rubocop and tests
Rubocop:
```
bundle exec rubocop 

# or, if you want it to autocorrect (when possible):
bundle exec rubocop -a
```
Run with the -A flag if you want it to autocorrect things if possible

Tests:
```
bundle exec rspec
```

Both:
```
bundle exec rake
```

### Start local webserver
```
bundle exec puma -p 8000
```

## Steps for adding a new entity
1. Add a migration file with the table structure to `./lib/migrations`
2. Add a new matching model for that table to `./lib/models`
3. Add a new controller (or expand an already existing one if it matches the purpose) to `./lib/web/controllers`
4. Make the router in `./lib/web/router.rb` support newly added controllers
5. Add routes and functionality to your controller

I'd suggest keeping the code clean by using serializer-, service- and repository-classes to encapsulate your functionality when adding new routes.
This repository also makes use of the `factory_bot` gem. Make sure to use it when writing tests.