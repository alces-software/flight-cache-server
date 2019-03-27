# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Configuration

This app uses figaro to configure certain components. See the example config for
details:

```
cat config/application.yml.example
```

# Accessing the RailsAdmin

The server does not keep a record of the current logged in user, and therefore
your credentials must be sent with every request. This makes using the
`RailsAdmin` a bit tricky, as it is the only component that is a web UI.

The easiest work around is the set your `flight_sso` token as a cookie. This
way it will automatically be sent with each request.

