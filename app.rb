require 'bundler'
require 'dotenv'
Bundler.require
$:.unshift File.expand_path("./../lib/views", __FILE__)
require 'index.rb'
Dotenv.load
index = Index.new
# index.call_scrapper
index.call_follower
# index.call_mailer
