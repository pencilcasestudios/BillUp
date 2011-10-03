class WelcomeController < ApplicationController
  layout "signed_out"
  
  def index
    if user_signed_in?
      render :signed_in_home, :layout => 'application'
    end
  end

  def pricing
  end

  def terms
  end

  def signed_in_home
  end

  def tour
  end
end
