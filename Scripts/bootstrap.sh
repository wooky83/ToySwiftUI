#!/bin/sh

# Install gems if a Gemfile exists
if [ -e "Gemfile" ]; then
  echo "installing ruby gems"
  # install bundler gem for ruby dependency management
  gem install bundler --no-document || echo "failed to install bundle"
  bundle config set deployment 'true'
  bundle config path vendor/bundle
  platform=$(ruby -r rbconfig -e "puts RbConfig::CONFIG['host_cpu'] + '-' + RbConfig::CONFIG['host_os']")
  bundle lock --add-platform "$platform"
  bundle install || echo "failed to install bundle"
fi
