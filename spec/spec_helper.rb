if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
else
  require 'simplecov'
  SimpleCov.start
end
# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require 'gitlab_git'
require File.join(File.dirname(__FILE__), '../support/valid_commit')
require 'pry'

RSpec::Matchers.define :be_valid_commit do
  match do |actual|
    actual != nil
    actual.id == ValidCommit::ID
    actual.message == ValidCommit::MESSAGE
    actual.author_name == ValidCommit::AUTHOR_FULL_NAME
  end
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.before(:all) do
    support_path = File.join(File.expand_path(File.dirname(__FILE__)), '../support')

    FileUtils.cd(support_path) do
      # Extract the archive
      `rm -rf gitlabhq.git`
      `tar -xf seed_project.tar.gz`
      `mv gitlabhq gitlabhq.git`
    end

    TEST_REPO_PATH = File.join(support_path, 'gitlabhq.git')
  end
end
