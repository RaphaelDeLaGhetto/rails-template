# rails-template

Just the usual stuff I need for a Rails app

# Usage

To generate a Rails application using this template, pass the `-m` option to `rails new`:

```
rails new myapp \
    -d postgresql \
    -m https://raw.githubusercontent.com/RaphaelDeLaGhetto/rails-template/master/template.rb
```

# Development

## Download

```
git clone https://github.com/RaphaelDeLaGhetto/rails-template.git
```

## Install dependencies

```
cd rails-template
bundle install
npm install
```

## Set up database

```
rake db:setup
```

### Test data

```
rake db:seed
```

## Configure

`config/application.yml` is where [figaro](https://github.com/laserlemon/figaro) stores all your secret configuration details, so you need to create it manually:

```
vim config/application.yml
```

Paste this and save:

```
# General
app_name: 'rails_template'
app_title: 'Ruby on Rails App'

# Email
default_from: 'noreply@example.com'
#gmail_username: "noreply@example.com"
#gmail_password: "secretp@ssword"

# Production
#host: "example.com"
#secret_key_base: "SomeRakeSecretHexKey"
#provider_database_password: 'secretp@ssword'
```

# Run server

```
rails s
```

# Rails test

```
rake
```

# React test

```
npm test
```

# License

MIT
