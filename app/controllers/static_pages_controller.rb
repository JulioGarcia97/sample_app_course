class StaticPagesController < ApplicationController
  def home
    @page_title = ''
  end

  def help
  	@page_title = 'Help'
  end

  def about
  	@page_title = 'About'
  end

  def contact
  	@page_title = 'Contact'
  end
end
