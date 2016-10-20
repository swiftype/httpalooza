# HTTPalooza: Ruby's greatest HTTP clients, on stage together

Your Ruby app includes a bunch of HTTP clients already. It's time to make use of them.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'httpalooza'
```

And then execute:

    $ bundle

HTTPalooza tracks the bleeding edge, so we recommend leaving the gem version unlocked for best results.

## Usage

```ruby
$ bundle exec bin/console
irb(main):001:0> ap HTTPalooza.invite.patron_to_the_party.and_use_typhoeus_too.lets_also_use_http_client_and_plain_old_curl_plus.rest_client_invited_itself_too.get("http://example.com")
{
         :patron => <HTTPalooza::Response:70225910064600 code=200 body="<!doctype html>\n<html>\n<...,
       :typhoeus => <HTTPalooza::Response:70225915728560 code=200 body="<!doctype html>\n<html>\n<...,
    :http_client => <HTTPalooza::Response:70225924014880 code=200 body="<!doctype html>\n<html>\n<...,
           :curl => <HTTPalooza::Response:70225919916880 code=200 body="<!doctype html>\n<html>\n<...
}
```

## Postgres Client

HTTPalooza uses Postgres's cutting edge technology, but needs your help to reach the clouds. Please install pgsql-http (https://github.com/pramsey/pgsql-http) along with Postgres (https://www.postgresql.org/) and create a database `httpalooza` with the `http` extension installed.

```
$ createdb httpalooza
$ psql httpalooza
httpalooza=# CREATE EXTENSION http;
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

### Adding adapters

HTTPalooza doesn't include an adapter for your favorite client? It's simple to add one. Create a new subclass of `HTTPalooza::Players::Base` and implement the `#response` method.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/httpalooza/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Do not bump the version in your pull request. We will do that in a separate commit (possibly including other changes).
