require 'sinatra'
require 'pg'
require 'json'

class App < Sinatra::Base
  get '/' do
    content_type :json
    {
      message: "Hello from Ruby Docker App!",
      timestamp: Time.now.iso8601,
      database_connected: database_connected?
    }.to_json
  end

  get '/health' do
    content_type :json
    {
      status: "healthy",
      database: database_connected? ? "connected" : "disconnected"
    }.to_json
  end

  private

  def database_connected?
    conn = PG.connect(
      host: ENV['DATABASE_HOST'] || 'localhost',
      port: ENV['DATABASE_PORT'] || 5432,
      dbname: ENV['DATABASE_NAME'] || 'rails_app_development',
      user: ENV['DATABASE_USERNAME'] || 'postgres',
      password: ENV['DATABASE_PASSWORD'] || 'password'
    )
    conn.exec('SELECT 1')
    conn.close
    true
  rescue
    false
  end
end

run App# Updated for demo
