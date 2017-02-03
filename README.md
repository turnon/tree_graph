# TreeGraph

A mixin to help you generate tree graph.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tree_graph'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tree_graph

## Usage

In Node class, `include TreeGraph`, then implement `parent_for_tree_graph`, `label_for_tree_graph`, `is_last_for_tree_graph`, you get `tree_graph_level`. To have `tree_graph`, also implement `children_for_tree_graph`.

Gems depending on this: [constree](https://github.com/turnon/constree), [trace_tree](https://github.com/turnon/trace_tree).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ken/tree_graph.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

