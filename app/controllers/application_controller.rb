class ApplicationController < ActionController::Base
  def index
    render template: 'application'
  end
end
