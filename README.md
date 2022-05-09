# README

# Quick Start
- Create the backend:             `rails db:create db:migrate db:seed`
  - You may have to download/install rails
- Install dependencies:           `bundle` and `yarn`
  - You may have to download bundler and/or yarn
- Start the server:               `rails s`
- Start the front-end dev server: `bin/vite dev`

If all went well, you should see "Hello World" at `localhost:3000`
# Record API

- Retrieving all records in a paginated fashion (defaults to 25 per page)
- Filtering records by title (pagination works with this, too)
- Finding the most common words across all albums
- Retrieving data about an artist's releases per year
- Updating records robustly
- Bulk creating new records via CSV

For more information, see the Postman documentation below.

## Install

### Clone the repository

```
git clone https://github.com/cprakti/bops.git
cd bops
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler)

```
bundle
```

### Initialize the database

```
rails db:create db:migrate db:test:prepare db:seed
```

## Serve

```
rails s
```

## Endpoint Documentation

https://documenter.getpostman.com/view/1486012/U16ewUY8

The API documentation can be downloaded and used via Postman. Visit the above link and click the Orange button 'Run in Postman'

Requirements:
- You may have to download Postman or register to use the web version
- You will need to have your local rails server running

## Data Model

![Data Model ERD](public/data_model.png?raw=true "Data Model ERD")


