class WelcomeController < ApplicationController
  skip_authorization_check

  def index
    if user_signed_in?
      render :signed_in_home
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

  def exception_test
  end
end
