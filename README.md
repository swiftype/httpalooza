# HTTPalooza

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/httpalooza`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'httpalooza'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install httpalooza

## Usage

```ruby
$ bundle exec bin/console
irb(main):001:0> ap HTTPalooza.invite.patron_to_the_party.and_use_typhoeus_too.lets_also_use_http_client_and_plain_old_curl_plus.rest_client_invited_itself_to.get("http://example.com")
{
         :patron => <HTTPalooza::Response:70225910064600 code=200 body="<!doctype html>\n<html>\n<...,
       :typhoeus => <HTTPalooza::Response:70225915728560 code=200 body="<!doctype html>\n<html>\n<...,
    :http_client => <HTTPalooza::Response:70225924014880 code=200 body="<!doctype html>\n<html>\n<...,
           :curl => <HTTPalooza::Response:70225919916880 code=200 body="<!doctype html>\n<html>\n<...
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/httpalooza/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
