class WelcomeController < ApplicationController
  def index
    current_user ? @tutorials = Tutorial.all : @tutorials = Tutorial.public_tutorials
    p = params
    if p[:tag]
      @tutorials = @tutorials.tagged_with(p[:tag]).paginate(page: p[:page],
                                                          per_page: 5)
    else
      @tutorials = @tutorials.paginate(page: p[:page], per_page: 5)
    end
  end

end
