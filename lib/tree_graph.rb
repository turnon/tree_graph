require "tree_graph/version"

module TreeGraph

  def tree_graph
    Node.new(self).tree_graph
  end

  class Node

    attr_accessor :is_last
    attr_reader :raw_node, :parent

    def initialize raw_node, parent=nil
      @raw_node, @parent, @is_last = raw_node, parent, false
    end

    def tree_graph
      ([level] +
       children_nodes.map(&:tree_graph)
      ).join("\n")
    end

    def children_nodes
      children = []
      raw_node.children_for_tree_graph.each do |c|
        children << Node.new(c, self)
      end
      return children if children.empty?
      children.last.is_last = true
      children
    end

    def level
      [indent, branch, raw_node.label_for_tree_graph].join
    end

    def ancestors
      return [] unless parent
      parent.ancestors + [parent]
    end

    def branch
      return '' unless parent
      is_last ? '└─' : '├─'
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
end
