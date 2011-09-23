class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      render :signed_in_home
    else
    end
  end

  def pricing
  end

  def signed_in_home
  end

  def terms
  end

  def tour
  end
end
