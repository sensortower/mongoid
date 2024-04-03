def standard_dependencies
  gem 'rake'

  group :development do
    gem 'yard'
  end

  group :development, :test do
    if RUBY_VERSION.start_with?('3.')
      # Get back to rspec-core after the following is fixed:
      # https://jira.mongodb.org/browse/MONGOID-5117
      gem 'rspec', '~> 3.10'
    elsif RUBY_VERSION.start_with?('2.')
      gem 'rspec-core', '~> 3.7'
    end

    platform :mri do
      if RUBY_VERSION < '2.3'
        gem 'byebug', '~> 10.0'
      else
        gem 'byebug'
      end
    end

    platform :jruby do
      gem 'ruby-debug'
    end
  end

  group :test do
    gem 'rspec-retry'
    gem 'benchmark-ips'
    if RUBY_VERSION.start_with?('2.')
      # Bring the dependencies back after the following is fixed:
      # https://jira.mongodb.org/browse/MONGOID-5117
      gem 'rspec-expectations', '~> 3.7', '>= 3.8.4'
      gem 'rspec-mocks-diag', '~> 3.0'
    end
    gem 'fuubar'
    gem 'rfc'
    gem 'childprocess'

    platform :mri do
      gem 'timeout-interrupt'
    end
  end
end

def base_i18n_versions
  i18n_versions = ['~> 1.0']

  if RUBY_VERSION < '2.3'
    i18n_versions << '< 1.5'
  end

  if RUBY_PLATFORM =~ /java/
    # https://github.com/jruby/jruby/issues/6573
    i18n_versions << '< 1.8.8'
  end

  i18n_versions
end

def nokogiri_dependency
  if RUBY_VERSION < '2.3'
    # nokogiri does not support 2.2 anymore.
    # https://github.com/sparklemotion/nokogiri/issues/1841
    # We are getting it as a transitive dependency
    gem 'nokogiri', '<1.10'
  end
end
