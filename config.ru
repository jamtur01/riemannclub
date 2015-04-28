$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "lib")))

ENV['RACK_ENV'] = 'production'

require 'rubygems'
require 'bundler'
require 'riemannclub'
require 'exceptional'

Exceptional::Config.load("config/exceptional.yml")

use Rack::Exceptional, 'bfc9e5ccf2d6f176b1e4a4b4f81bea41c336f47b'

require 'logger'
class ::Logger; alias_method :write, :<<; end

logger = Logger.new('log/app.log')
use Rack::CommonLogger, logger

use Rack::ShowExceptions

run RiemannClub::Application.new
