## Table of contents
- [Table of contents](#table-of-contents)
- [General info](#general-info)
- [Technologies](#technologies)
- [Setup](#setup)

## General info
This project is a basic API implementation to get the population data based on the zip code given.

## Technologies
Project is created with:
* Ruby version: 2.5.1
* Rails version: 5.2.4

## Setup
To run this project

1. Create a `.env` file and populate it with the correct URLs to the remote CSV files

```
ZIP_TO_CBSA=link/to/csv
CBSA_TO_MSA=link/to/csv
```

2. Install it locally using bundler:

```
$ bundle install
```

3. Set up the database:

```
$ bin/rails db:create && bin/rails db:migrate
```

4. Start the Rails server:

```
$ bin/rails s
```