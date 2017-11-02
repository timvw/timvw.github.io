# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "type-on-strap"
  spec.version       = "0.9"
  spec.authors       = ["Sylhare","Rohan Chandra"]
  spec.email         = ["", "hellorohan@outlook.com"]

  spec.summary       = %q{A custom type-theme template (a free and open-source Jekyll theme. Great for blogs and easy to customize.)}
  spec.homepage      = "https://github.com/sylhare/Type-on-Strap"
  spec.license       = "MIT"

  spec.files         = Dir.glob("**/{*,.*}").select do |f|
    f.match(%r{^(assets|pages|_(portfolio|includes|layouts|sass)/|(LICENSE|Gemfile|_config.yml|index.html)((\.(txt|md|markdown)|$)))}i)
  end

  spec.add_runtime_dependency "jekyll", "~> 3.4"
  spec.add_runtime_dependency "jekyll-paginate", "~> 1.1"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
