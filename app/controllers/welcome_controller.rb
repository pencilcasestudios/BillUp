class WelcomeController < ApplicationController
  layout "signed_out"
  
  def index
    if user_signed_in?
      redirect_to dashboard_path
    end
  end

  def pricing
  end

  def terms
  end

  def tour
  end
end
