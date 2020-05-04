class WelcomeController < ApplicationController
  def index
    p = params
    if p[:tag]
      @tutorials = Tutorial.tagged_with(p[:tag]).paginate(page: p[:page],
                                                          per_page: 5)
    else
      @tutorials = Tutorial.all.paginate(page: p[:page], per_page: 5)
    end
  end
end
