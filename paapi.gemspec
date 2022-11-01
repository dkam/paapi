lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paapi/version'

Gem::Specification.new do |spec|
  spec.name          = 'paapi'
  spec.version       = Paapi::VERSION
  spec.authors       = ['Dan Milne']
  spec.email         = ['d@nmilne.com']

  spec.summary       = %q{Client library for Amazon's Product Advertising API v5}
  spec.homepage      = 'https://github.com/dkam/paapi'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/dkam/paapi/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '>= 12.3.r3'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'byebug', '~> 11'
  spec.add_development_dependency 'awesome_print', '~> 1.8'

  spec.add_dependency 'aws-sigv4', '~> 1'
  spec.add_dependency 'net-http-persistent', '~> 4.0', '>= 4.0.1'
end
