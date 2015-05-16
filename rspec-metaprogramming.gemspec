# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "rspec-metaprogramming"
  spec.version       = "0.1.0"
  spec.authors       = [ "Andy Palmer", "Antony Marcano" ]
  spec.email         = [ "rspec-metaprogramming@riverglide.com" ]
  spec.description   = "Matchers that assist when writing metaprograms"
  spec.summary       = "Does what it says on the tin"
  spec.homepage      = "https://github.com/riverglide/rspec-metaprogramming.git"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rspec', "~> 3.2"
end
