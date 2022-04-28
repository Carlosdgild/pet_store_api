# Pet Store API

Pet Store API exercise.

## Installation

1. Clone or download repository.
2. Have PostreSQL 10.X (or greater) and Ruby 3.0.3 installed.
3. Create a `.env` file at the root of the project with the specified values in `.env.sample`. Modify accordingly the values where needed
4. Run:

    ```bash
    bin/setup
    ```
5. Run tests with:
    ```bash
    RAILS_ENV=test bundle exec rspec
    ```
6. You can start the API with:
    ```bash
    rails s
    ```
7. You can access the Swagger docs on [/api-docs](http://localhost:3000/api-docs)
