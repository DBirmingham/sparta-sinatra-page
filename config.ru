require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?
require_relative './controllers/posts_controller.rb'
require_relative './models/post.rb'

use Rack::Reloader
use Rack::MethodOverride

run PostsController