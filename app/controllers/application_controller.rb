class ApplicationController < ActionController::Base
  # disabling CSRF protection
  skip_forgery_protection
end

