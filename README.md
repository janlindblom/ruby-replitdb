# Replit Database client

Replit Database client is a simple way to use Replit Database in your Ruby repls.

Based on the [Node.js Replit Database client](https://github.com/replit/database-node).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'replitdb'
```

## Usage

Require it in your code:

```ruby
require 'replit'
client = Replit::Database::Client.new
client.set "key", "value"
key = client.get "key"
puts key
```

### Library documentation

#### Constructor

```ruby
Replit::Database::Client.new(custom_url)
```

Constructor takes a custom database URL as an optional argument.

#### Functions

```ruby
get(key, {raw: false})
```

Gets the value of a key from the database, specifying passing the optional `raw: true` option returns the raw value stored, otherwise it will be deserialized as JSON into a Ruby object.

```ruby
set(key, value)
```

Sets the value of a key in the database.

```ruby
delete(key)
```

Deletes `key` from database.

```ruby
list(prefix="")
```

List all of the keys, or if prefix is defined all of the keys starting with `prefix`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/janlindblom/ruby-replitdb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/janlindblom/ruby-replitdb/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ruby::Replitdb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/janlindblom/ruby-replitdb/blob/master/CODE_OF_CONDUCT.md).
