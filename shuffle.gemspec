Gem::Specification.new do |spec|
  spec.name        = "shuffle"
  spec.version     = "0.1.0"
  spec.summary     = "n-mer shuffling."
  spec.description = "Simple method to shuffle list while preserving n-mer frequency."
  spec.authors     = ["Evan Senter"]
  spec.email       = "evansenter@gmail.com"
  spec.files       = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  spec.homepage    = "http://rubygems.org/gems/shuffle"
  
  spec.add_dependency("rand", [">= 0.9.1"])
end