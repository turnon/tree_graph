require 'test_helper'

class TreeGraphTest < Minitest::Test

  class TestNode

    include TreeGraph

    def label_for_tree_graph
      "#{@word.upcase} (#{@word})"
    end

    def children_for_tree_graph
      sub_nodes
    end

    def initialize word
      @word = word
    end

    def << child
      sub_nodes << child
    end

    def sub_nodes
      @sub_nodes ||= []
    end

  end

  def setup
    %w{a b c d e f g h}.each do |w|
      instance_variable_set "@#{w}", TestNode.new(w)
    end
    @a << @b << @c << @e
    @c << @g << @d << @f
    @d << @h
  end

  def test_that_it_has_a_version_number
    refute_nil ::TreeGraph::VERSION
  end

  def test_tree_graph
    tree = <<EOS
A (a)
├─B (b)
├─C (c)
│ ├─G (g)
│ ├─D (d)
│ │ └─H (h)
│ └─F (f)
└─E (e)
EOS
    assert_equal tree.chomp, @a.tree_graph
  end
end
