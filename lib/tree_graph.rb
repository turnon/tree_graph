require "tree_graph/version"

module TreeGraph

  def tree_graph
    ([tree_graph_level] +
     children_for_tree_graph.map(&:tree_graph)
    ).join("\n")
  end

  def tree_graph_level
    tree_graph_indent +
      tree_graph_branch +
      label_for_tree_graph
  end

  def tree_graph_ancestors
    return [] unless parent_for_tree_graph
    parent_for_tree_graph.tree_graph_ancestors + [parent_for_tree_graph]
  end

  def tree_graph_branch
    return '' unless parent_for_tree_graph
    is_last_for_tree_graph ? '└─' : '├─'
  end

  def tree_graph_indent
    tree_graph_ancestors.map do |a|
      unless a.parent_for_tree_graph
        ''
      else
        a.is_last_for_tree_graph ? ' ' : '│ '
      end
    end.join
  end
end
