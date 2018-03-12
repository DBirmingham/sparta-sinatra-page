require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?
require_relative './controllers/order_controller.rb'
require_relative './models/order.rb'

use Rack::Reloader
use Rack::MethodOverride

run OrderController