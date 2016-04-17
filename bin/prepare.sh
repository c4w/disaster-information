#!/usr/bin/env bash

set -e

bundle install --path vendor/bundle
bundle exec jekyll build
