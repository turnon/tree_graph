require 'test_helper'

class TreeGraphTest < Minitest::Test

  class TestNode

    include TreeGraph

    def parent_for_tree_graph
      parent
    end

    def label_for_tree_graph
      "#{@word.upcase} (#{@word})"
    end

    def is_last_for_tree_graph
      return true unless parent
      siblings = parent.sub_nodes
      siblings.index(self) == (siblings.count - 1)
    end

    def children_for_tree_graph
      sub_nodes
    end

    attr_accessor :parent

    def initialize word
      @word = word
    end

    def << child
      sub_nodes << child
      child.parent = self
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

  def test_tree_graph_ancestors
    assert_equal [], @a.tree_graph_ancestors
    assert_equal [@a], @b.tree_graph_ancestors
    assert_equal [@a], @c.tree_graph_ancestors
    assert_equal [@a, @c], @d.tree_graph_ancestors
    assert_equal [@a], @e.tree_graph_ancestors
    assert_equal [@a, @c], @f.tree_graph_ancestors
    assert_equal [@a, @c], @g.tree_graph_ancestors
    assert_equal [@a, @c, @d], @h.tree_graph_ancestors
  end

  def test_tree_graph_branch
    assert_equal '', @a.tree_graph_branch
    assert_equal '├─', @b.tree_graph_branch
    assert_equal '├─', @c.tree_graph_branch
    assert_equal '├─', @d.tree_graph_branch
    assert_equal '└─', @e.tree_graph_branch
    assert_equal '└─', @f.tree_graph_branch
    assert_equal '├─', @g.tree_graph_branch
    assert_equal '└─', @h.tree_graph_branch
  end

  def test_tree_graph_indent
    assert_equal '', @a.tree_graph_indent
    assert_equal '', @b.tree_graph_indent
    assert_equal '', @c.tree_graph_indent
    assert_equal '│ ', @d.tree_graph_indent
    assert_equal '', @e.tree_graph_indent
    assert_equal '│ ', @f.tree_graph_indent
    assert_equal '│ ', @g.tree_graph_indent
    assert_equal '│ │ ', @h.tree_graph_indent
  end

  def test_tree_graph_level
    assert_equal 'A (a)', @a.tree_graph_level
    assert_equal '├─B (b)', @b.tree_graph_level
    assert_equal '├─C (c)', @c.tree_graph_level
    assert_equal '│ ├─G (g)', @g.tree_graph_level
    assert_equal '│ ├─D (d)', @d.tree_graph_level
    assert_equal '│ │ └─H (h)', @h.tree_graph_level
    assert_equal '│ └─F (f)', @f.tree_graph_level
    assert_equal '└─E (e)', @e.tree_graph_level
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
