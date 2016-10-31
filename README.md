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

## Oracle PL/SQL (Procedural Language / Structured Query Language) Adapter

We want HTTPalooza to support all stacks and architectures. Absolutely no one has called us out on only supporting Postgres, and we want to keep it that way.

To help streamline your Oracle development setup, there's a [local development virtual machine](http://www.oracle.com/technetwork/database/enterprise-edition/databaseappdev-vm-161299.html) and a [tutorial](http://www.baldwhiteguy.co.nz/technical/index_files/mac-osx-oracle-instantclient.html) on how to install Oracle's instantclient. Keep in mind the tutorial is installing a version `11_2`, which is outdated, so adjust your path if you are installing a newer version of oracle instant client (at the current moment it is version `12_1`). In order for your local machine to connect with the virtual machine, make sure you have port forwarding from port `1521` on your virtual machine to localhost port `1521`. This [link](https://mikesmithers.wordpress.com/2015/01/25/installing-and-configuring-an-oracle-developer-day-virtualbox-image/) might be helpful. Good luck.

The defaults for the virtual machine are with user `system` with password `oracle` and runs on port `1521`. HTTPalooza uses these and isn't yet configurable.

Next part is deliberately manual. Start up sqlplus:

> $ORACLE_HOME/sqlplus system/oracle@localhost

Now open up network connections for the `system` user.

```
BEGIN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL('httpalooza.xml', 'Allow usage to the UTL network packages', 'SYSTEM', TRUE, 'connect');
  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE('httpalooza.xml' ,'SYSTEM', TRUE, 'resolve');
  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE('httpalooza.xml' ,'SYSTEM', TRUE, 'connect');
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL('httpalooza.xml','*');
END;
```

If you want validation or want to understand what these lines of PL/SQL do, you can find that information in a [non-verified blog](https://www.pythian.com/blog/setting-up-network-acls-in-oracle-11g-for-dummies/) or the [Oracle documentation](https://docs.oracle.com/cd/B28359_01/appdev.111/b28419/d_networkacl_adm.htm).


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
