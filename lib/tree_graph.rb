require "tree_graph/version"

module TreeGraph

  def tree_graph
    TopDown.new(self).tree_graph
  end

  def tree_graph_bottom_up
    BottomUp.new(self).tree_graph
  end

  def tree_graph_bottom_up_in_same_order
    BottomUpInSameOrder.new(self).tree_graph
  end

  module Node

    attr_accessor :is_last
    attr_reader :raw_node, :parent

    def initialize raw_node, parent=nil
      @raw_node, @parent, @is_last = raw_node, parent, false
    end

    def children_nodes
      children.map do |c|
        self.class.new(c, self)
      end.tap do |nodes|
        nodes.last.is_last = true unless nodes.empty?
      end
    end

    def children
      raw_node.children_for_tree_graph
    end

    def level
      [indent, branch, raw_node.label_for_tree_graph].join
    end

    def levels
      [level] + children_nodes.map(&:tree_graph)
    end

    def ancestors
      return [] unless parent
      parent.ancestors + [parent]
    end

    def indent
      ancestors.map do |a|
        unless a.parent
          ''
        else
          a.is_last ? '  ' : '│ '
        end
      end.join
    end

  end

  class TopDown
    include Node

    def tree_graph
      levels.join("\n")
    end

    def branch
      return '' unless parent
      is_last ? '└─' : '├─'
    end
  end

  class BottomUp
    include Node

    def tree_graph
      levels.reverse.join("\n")
    end

    def branch
      return '' unless parent
      is_last ? '┌─' : '├─'
    end
  end

  class BottomUpInSameOrder < BottomUp
    def children
      super.reverse
    end
  end
end
