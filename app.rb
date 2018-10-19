$:.unshift File.expand_path("./../lib/views", __FILE__)
require 'bundler'
Bundler.require
require 'dotenv'
Dotenv.load
require 'index.rb'
index = Index.new
index.start