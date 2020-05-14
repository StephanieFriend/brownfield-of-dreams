class WelcomeController < ApplicationController
  def index
    (@tutorials = Tutorial.all) if current_user
    (@tutorials = Tutorial.public_tutorials) unless current_user
    p = params
    if p[:tag]
      @tutorials = @tutorials.tagged_with(p[:tag]).paginate(page: p[:page],
                                                            per_page: 5)
    else
      @tutorials = @tutorials.paginate(page: p[:page], per_page: 5)
    end
  end
end
