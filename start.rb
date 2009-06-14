require 'rubygems'
require 'activerecord'
require 'activesupport'
require 'action_view/helpers'
#require 'activeresource'
#require 'actionpack'
#require 'base64'
#require "cgi"
#require "cgi/session"
require 'digest/sha1'
require 'openssl'
require 'pp'
require 'sinatra'
require 'will_paginate'
require 'will_paginate/core_ext'
require 'will_paginate/view_helpers'

set :views, File.dirname(__FILE__) + '/app/views'
enable :sessions
Rack::Handler.register 'Webrick', 'Rack::Handler::WEBrick'
WillPaginate.enable_activerecord

db_config = YAML::load_file('config/database.yml')
ActiveRecord::Base.establish_connection(db_config) 

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  include WillPaginate::ViewHelpers
end

( Dir::glob("app/controllers/*.rb") ).each do |controller|
  load controller
end

( Dir::glob("app/models/*.rb") ).each do |model|
  require model
end

