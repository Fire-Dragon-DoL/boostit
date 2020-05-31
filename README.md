# Boostit

## Boom

The project is a Ruby on Rails application, generated using the following
command:

```bash
rails new boom \
  --database=postgresql \
  --skip-action-mailer \
  --skip-action-mailbox \
  --skip-action-text \
  --skip-active-storage \
  --skip-action-cable \
  --skip-sprockets \
  --skip-spring \
  --skip-listen \
  --skip-javascript \
  --skip-turbolinks \
  --skip-system-test \
  --skip-bootsnap \
  --api \
  --skip-webpack-install
```

## Notes
The actual domain logic is kept in `lib/domain` to isolate from Rails.
The domain however is very simple in this case, so the advantages don't surface
(isolation from database, easier Rails upgrades).

### Date
The date you're submitting this.

### Location of deployed application
If applicable, please provide the url where we can find and interact with your running application.

### Time spent
How much time did you spend on the assignment? Normally, this is expressed in hours.

### Assumptions made
- `/current` endpoint will return `0` if `/next` was never called
- `/next` will return `1` the first time is called and `/current` has never
  been set
- Maximum value returned by `/next` is maximum 64-bit signed integer:
  `9_223_372_036_854_775_807`
- Maximum value that can be set to `/current` is maximum 64-bit signed integer:
  `9_223_372_036_854_775_807`
- Minimum value that can be set to `/current` is `0`
- The project can't match JSONAPI specifications correctly due to business
  specifications (e.g. `GET` for `/next`, `PUT` for `/current`)

### Shortcuts/Compromises made
- Devise configuration has problems with documentation, it was difficult to
  configure it properly and the general configuration can be improved
- JWT needs blacklisting implemented and a lower expiration time for the tokens
- `docker-compose` uses a simple `sleep` to start the application after the
  databases. This could be improved with a script testing if databases are
  running

### Stretch goals attempted
If applicable, use this area to tell us what stretch goals you attempted. What went well? What do you wish you
could have done better? If you didn't attempt any of the stretch goals, feel free to let us know why.

### Instructions to run assignment locally

Set the following environment variables based on your system:

```bash
export REDIS_URL="redis://localhost:6400/15"
export REDIS_PROVIDER='REDIS_URL'
export DATABASE_URL="postgres://postgres:whatever@localhost:5400/boom_development"
```

- Have a redis instance running
- Have a Postgres instance running, with a database named `boom_development`
  created and `create extension pgcrypto` for such database.
- Make sure port `3001` is available for localhost.
- Run `./bin/rails db:migrate`
- Run `./bin/rails s` from `boom` directory.

If `docker` and `docker-compose` are installed and postgres and redis are
not present on the system, it's possible to execute the following command:

```bash
docker-compose up --build`
```

This will start the application on port `3001`.
Notice that the application starts after 30 seconds but the databases might
not have started yet. Please increase this delay by modifying `boom/start.sh`.

#### Testing

To execute the test suite locally, the following commands can be executed from
the root directory:

```bash
docker-compose -f docker-compose.yml -f docker-compose.test.yml up --build
```

Notice that the test suite starts after 30 seconds but the databases might
not have started yet. Please increase this delay by modifying `boom/test.sh`.

### What did you not include in your solution that you want us to know about?
Were you short on time and not able to include something that you want us to know
about? Please list it here so that we know that you considered it.

### Other information about your submission that you feel it's important that we know if applicable.
### Your feedback on this technical challenge
Have feedback for how we could make this assignment better? Please let us know.
