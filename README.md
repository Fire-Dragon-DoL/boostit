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
- UI: [https://boostit-poke.herokuapp.com/](https://boostit-poke.herokuapp.com/)
- API: [https://boostit-boom.herokuapp.com/](https://boostit-boom.herokuapp.com/)

### Time spent
15 hours, divided as:
- Authentication, 4 hours
- HTTP API endpoints and business logic 2 hours
- JSONAPI specification 4 hours
- UI 4 hours (3 hours spent on CORS issues)
- Deployment 1 hour

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
  separating those into different objects and use them through dependency
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
  The ID would be the user id, which should not be needed to execute a request
  on this HTTP API endpoint
- JSONAPI expects request params to be in body and be inside a `data` attribute
  in a top-level object. This removes some flexibility from the API and
  it's difficult to implement with `warden` and `devise`. This part of the
  spec was not respected in the context of this project
- The UI is implemented poorly and in hurry, but it provides a good baseline
  to test the application directly in the browser
- `master.key` file is deployed for ease of use, but should never be committed
  in a real-world project
- Docker build pipeline can be better organized instead of duplicate
  environment variables

### Stretch goals attempted
- UI is provided
- Devise was chosen to integrate OAuth.
  I regretted using it since the purpose was to ease the integration of
  OAuth but it increased the development time so I wasn't able to work
  properly on this stretch-goal

### Instructions to run assignment locally

#### Without Docker

##### Requirements

- Ruby 2.7
- Bundler 2.x
- NodeJS 14.x
- Yarn or npm
- Port 3001 and 3002 available on localhost
- Postgres running
- Redis running

##### Instructions

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

- Create a Postgres database named `boom_development` and
  `create extension pgcrypto` for such database.

Inside `boom` directory, run the following commands:

```bash
bundle install
./bin/rails db:migrate
./bin/rails s
```

Inside `poke` directory, run the following commands:

```bash
yarn install
export PORT=3002
yarn start
```

#### With Docker

##### Requirements

- Docker
- `docker-compose`
- Port 3001, 3002, 6400 and 5400 available on localhost

##### Instructions

Inside the root directory of the project, execute the following commands:

```bash
docker-compose up --build`
```

This will start the application on port `3001` and UI on port `3002`.
Notice that the applications start after 30 seconds but the databases might
not have started yet. Please increase this delay by modifying `boom/start.sh`.
and `poke/start.sh`

##### Automated Testing

To execute the test suite locally, the following commands can be executed from
the root directory:

```bash
docker-compose -f docker-compose.yml -f docker-compose.test.yml up --build
```

Notice that the test suite starts after 30 seconds but the databases might
not have started yet. Please increase this delay by modifying `boom/test.sh`.

#### Interactive Testing

Example `curl` commands can be found in `boom/interactive` directory.
It's possible to execute interactive tests by running them from `boom`
directory. For example, the following interactive test will reset the current
sequence number to 100:

```bast
cd boom
./interactive/reset.sh 100
```

### What did you not include in your solution that you want us to know about?

A pleasant user interface is missing (no CSS applied to the existing one).

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

I recommend removing the authentication requirement and focus more on
business logic, adding more details on that side.
Authentication is something that is not touched often and tend to be specific
to frameworks, so it ends up being more "configuration" rather than coding.

The `curl` usage examples provided in the requirements document are incorrect
since they don't pass the headers needed to respect JSONAPI.
