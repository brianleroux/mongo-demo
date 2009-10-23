%w(rubygems sinatra/base mongomapper ).each { |x| require x  } 

MongoMapper.database = 'testing'


class Thing
  include MongoMapper::Document  
  key :stuff, String
  key :junk, String, :required=>true
end


class App < Sinatra::Base
  
  enable :sessions
  enable :methodoverride 
  
  set :static, true
  set :public, File.dirname(__FILE__) + '/public'
  set :logging, true
  set :dump_errors, true
  

  get '/' do
    @things = Thing.find(:all)
    erb :index
  end 
  
  post '/' do
    Thing.create(params['thing'])
    redirect '/'
  end 
  
  delete '/' do
    Thing.destroy(params['id'])
    redirect '/'
  end 
  
  put '/' do
    @thing = Thing.find(params['thing']['id'])
    @thing.update_attributes(params['thing'])
    redirect '/'
  end 
  # end of app
end
