$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'mtrc/version'
require 'find'
 
# Don't include resource forks in tarballs on Mac OS X.
ENV['COPY_EXTENDED_ATTRIBUTES_DISABLE'] = 'true'
ENV['COPYFILE_DISABLE'] = 'true'
 
# Gemspec
gemspec = Gem::Specification.new do |s|
  s.rubyforge_project = 'mtrc'
 
  s.name = 'mtrc'
  s.version = Mtrc::VERSION
  s.author = 'Kyle Kingsbury'
  s.email = 'aphyr@aphyr.com'
  s.homepage = 'https://github.com/aphyr/mtrc'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Minimal metric aggregation.'
 
  s.files = FileList['{lib}/**/*', 'LICENSE', 'README.markdown'].to_a
  s.executables = []
  s.require_path = 'lib'
  s.has_rdoc = true
 
  s.required_ruby_version = '>= 1.8.7'
end
 
Rake::GemPackageTask.new(gemspec) do |p|
  p.need_tar_gz = true
end
 
Rake::RDocTask.new do |rd|
  rd.main = 'Mtrc'
  rd.title = 'Mtrc'
  rd.rdoc_dir = 'doc'
 
  rd.rdoc_files.include('lib/**/*.rb')
end
