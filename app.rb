require 'bundler'
Bundler.require
$:.unshift File.expand_path("./../lib/views", __FILE__)
require 'index.rb'

index = Index.new
index.call_db

index.start
index.call_scrapper