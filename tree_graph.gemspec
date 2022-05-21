# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tree_graph/version'

Gem::Specification.new do |spec|
  spec.name          = "tree_graph"
  spec.version       = TreeGraph::VERSION
  spec.authors       = ["ken"]
  spec.email         = ["block24block@gmail.com"]

  spec.summary       = %q{A mixin to help you generate tree graph}
  spec.homepage      = "https://github.com/turnon/tree_graph"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.2.33"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.0"
end
