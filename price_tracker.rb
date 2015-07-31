#!/usr/bin/env ruby
require 'rubygems'
require 'bundler'
Bundler.require
require_relative 'url_utils'
Dir[File.dirname(__FILE__)  + '/parsers/*.rb'].each {|file| require file }

if (ENV['RAILS_ENV'])
  db_user = ENV['DB_USERNAME']
  db_password = ENV['DB_PASSWORD']
  db_host = ENV['DB_ADDRESS']
else
  db_user = 'shadowjack'
  db_password = ''
  db_host = 'localhost'
end

DB = Sequel.postgres(
  'PriceTracker_development', 
  :user => db_user, 
  :password => db_password, 
  :host => db_host)

logger = Logging.logger('db_logger')
logger.level = :info
logger.add_appenders Logging.appenders.file('db.log')
DB.loggers << logger

agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'

products = DB[:products]
products.all do |product| 
  if (!validate_url product[:url])
    logger.error "Wrong url: " + product[:url]
    next
  end

  page = agent.get product[:url]
  
  if (product[:description].to_s == '')
    logger.info "Getting description for #{product[:url]}"
    description = OzonParser.get_description(page)
    DB[:products].where(id: product[:id]).update(description: description) unless description.empty?
  end

  current_price = OzonParser.get_price(page)
  DB[:prices].insert product_id: product[:id], price: current_price.to_i, created_at: DateTime.now, updated_at: DateTime.now
  
end
