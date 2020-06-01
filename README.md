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
2020-05-31

### Location of deployed application
If applicable, please provide the url where we can find and interact with your running application.

### Time spent
14 hours, divided as:
- Authentication, 4 hours
- HTTP API endpoints and business logic 2 hours
- JSONAPI specification 4 hours
- UI 4 hours (CORS issues)

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
- `PUT /current` expects either a url parameter `current` or
  a JSON object in the body with the shape `{ "current": integer }`

### Shortcuts/Compromises made
- Devise configuration has problems with documentation, it was difficult to
  configure it properly and the general configuration can be improved
- JWT needs blacklisting implemented and a lower expiration time for the tokens
- `docker-compose` uses a simple `sleep` to start the application after the
  databases. This could be improved with a script testing if databases are
  running
- The Set/Put/Increment objects shouldn't be used directly but top-level
  business objects named `Current`, `Next` and `Reset` should be used.
  However the business logic was so shallow that I couldn't justify
  separating them into different object and use them through dependency
  injection
- Sign-out process is omitted due to the lack of JWT black-listing
- JSONAPI specifications instructs to exclude any media type parameters in
  the content-type header. Rails ignores the value `charset` set to `nil`,
  appending `utf-8` to the content-type independently of the configured value.
  I wasn't able to resolve this problem with the time allocated
- Missing testing about headers to respect JSONAPI specification
- A `PUT` request is not mentioned in the JSONAPI specification. Presuming
  an update request for `/current`, it should also provide an id on the top
  level object which doesn't make sense given the context of this project.
  The ID would be the user id, which should not be needed execute a request
  on this HTTP API endpoint
- JSONAPI expects request params to be in body and be inside a `data` attribute
  in a top-level object. This removes some flexibility from the API and
  it's difficult to implement with `warden` and `devise`. This part of the
  spec was not respected in the context of this project
- The UI is implemented poorly and in hurry, but it provides a good baseline
  to test the application directly in the browser

### Stretch goals attempted
- Devise was chosen to integrate OAuth.
  I regretted using it since the purpose was to ease the integration of
  OAuth but it increased the development time so I wasn't able to work
  properly on this stretch-goal

### Instructions to run assignment locally

Set the following environment variables based on your system:

```bash
export REDIS_URL="redis://localhost:6400/15"
export REDIS_PROVIDER='REDIS_URL'
export DATABASE_URL="postgres://postgres:whatever@localhost:5400/boom_development"
# Location of rails app (API)
export REACT_APP_BOOM_URL='http://localhost:3001/v1'
# Domain of frontend app
export BOOM_CORS_DOMAIN='localhost:3002'
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

A pleasant user interface is missing.

### Other information about your submission that you feel it's important that we know if applicable.
- Devise stretches is set to 12 and includes a pepper to respect
  [OWASP recommendations on password storage security](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html)
- JWT was used to ensure fast authentication performance, in combination
  with Redis as storage (instead of Postgres) for the sequence numbers
  ensuring very short response times
- Due to the requirement of having the sequences "gapless", this project
  has limitations in terms of scaling due to having a single access point to
  determine the next sequence number

### Your feedback on this technical challenge

I recommend removing the authentication requirement and focus a more on
business logic, making it a bit more complex.
Authentication is something that is not touched often and tend to be touched
by frameworks, so it ends up being more "configuration" rather than coding.

The `curl` usage examples are incorrect since they don't pass the headers
needed to respect JSONAPI.
