class ApplicationController < ActionController::API
  def index
    render json: { 
      message: "Hello from Rails Docker App!", 
      timestamp: Time.current,
      database_connected: database_connected?
    }
  end

  def health
    render json: { 
      status: "healthy", 
      database: database_connected? ? "connected" : "disconnected"
    }
  end

  private

  def database_connected?
    ActiveRecord::Base.connected?
  rescue
    false
  end
end