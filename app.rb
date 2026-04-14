require 'sinatra'
require 'json'

# In-memory storage
class ItemStore
  @@items = {}
  @@next_id = 1

  def self.all
    @@items.values
  end

  def self.find(id)
    @@items[id]
  end

  def self.create(name)
    item = { id: @@next_id, name: name }
    @@items[@@next_id] = item
    @@next_id += 1
    item
  end

  def self.reset
    @@items = {}
    @@next_id = 1
  end
end

# Routes
get '/health' do
  content_type :json
  { status: 'ok' }.to_json
end

get '/items' do
  content_type :json
  ItemStore.all.to_json
end

post '/items' do
  content_type :json
  
  begin
    data = JSON.parse(request.body.read)
  rescue JSON::ParserError
    halt 400, { error: 'Invalid JSON Item' }.to_json
  end

  if data['name'].nil? || data['name'].empty?
    halt 400, { error: 'name is required' }.to_json
  end

  item = ItemStore.create(data['name'])
  status 201
  item.to_json
end

get '/items/:id' do
  content_type :json
  id = params[:id].to_i
  
  item = ItemStore.find(id)
  if item
    item.to_json
  else
    halt 404, { error: 'Not Found' }.to_json
  end
end
