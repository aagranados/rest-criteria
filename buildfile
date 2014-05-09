require 'buildr/git_auto_version'
require 'buildr/top_level_generate_dir'
require 'buildr/gpg'

desc "RestCriteria: Simple library for parsing criteria in rest services"
define 'rest-criteria' do
  project.group = 'org.realityforge.rest.criteria'
  compile.options.source = '1.6'
  compile.options.target = '1.6'
  compile.options.lint = 'all'

  project.version = ENV['PRODUCT_VERSION'] if ENV['PRODUCT_VERSION']

  pom.add_apache2_license
  pom.add_github_project('realityforge/rest-criteria')
  pom.add_developer('realityforge', 'Peter Donald')
  pom.provided_dependencies.concat [:javax_annotation]

  compile.with Buildr::Antlr4.runtime_dependencies, :javax_annotation

  compile.from compile_antlr(_('src/main/antlr/RestCriteriaExpr.g4'), :package => 'org.realityforge.rest.criteria')

  test.using :testng

  package(:jar)
  package(:sources)
  package(:javadoc)
end

desc "Generate source artifacts"
task('domgen:all').enhance([file(File.expand_path("#{File.dirname(__FILE__)}/generated/antlr/main/java"))])
