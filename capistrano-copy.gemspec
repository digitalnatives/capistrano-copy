# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = 'capistrano-copy'
  s.version     = '1.0.0'
  s.licenses    = ['MIT']
  s.authors     = ['Gusztáv Szikszai']
  s.email       = ['gusztav.szikszai@digitalnatives.hu']
  s.homepage    = 'https://github.com/digitalnatives/capistrano-copy'
  s.summary     = 'Copy strategy for capistrano 3.x'
  s.description = 'Copy strategy for capistrano 3.x'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n")
                                           .map { |f| File.basename(f) }

  s.require_paths = ['lib']

  # specify any dependencies here; for example:
  s.add_dependency 'capistrano', '~> 3.0'
end
