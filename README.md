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

In Node class, `include TreeGraph`, then implement two methods, `label_for_tree_graph` and `children_for_tree_graph`(which return thing responds to `each`). Then you can call `tree_graph` on that Node object.

Or checkout [test/tree_graph_test.rb](https://github.com/turnon/tree_graph/blob/master/test/tree_graph_test.rb) to see how to use.

Gems depending on tree_graph: [constree](https://github.com/turnon/constree), [trace_tree](https://github.com/turnon/trace_tree).

