require_relative 'lib/tweetkit/version'

Gem::Specification.new do |spec|
  spec.name          = "tweetkit"
  spec.version       = Tweetkit::VERSION
  spec.authors       = ["Julian Foo"]
  spec.email         = ["juliandevmy@gmail.com"]

  spec.summary       = %q{WIP: Simple API wrapper for Twitter's V2 API}
  spec.description   = %q{WIP: Tweetkit is a Ruby wrapper for Twitter's V2 API}
  spec.homepage      = "https://github.com/julianfssen/tweetkit"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 2.2"
  spec.add_dependency "simple_oauth", "~> 0.3"
  spec.add_dependency "zeitwerk", "~> 2.5"

  spec.add_development_dependency "debug"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "yard"
end
