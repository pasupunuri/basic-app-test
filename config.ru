require 'sinatra'
require 'sequel'
require 'pg'

# Connect to the database
DB = Sequel.connect(ENV['DB'])

# Create the "data" table if it doesn't exist
DB.create_table? :data do
  primary_key :id
  String :get_data
  String :post_data
end

get '/' do
  data = DB[:data]
  data.insert(get_data: params.to_s)
  "GET data saved to database"
end

post '/' do
  request.body.rewind
  post_data = request.body.read
  data = DB[:data]
  data.insert(post_data: post_data)
  "POST data saved to database"
end


get '/data' do
  DB[:data].last(20)
end
