class HomeController < ApplicationController
  def index
    if !current_school
      redirect_to new_school_path, notice: 'Bem vindo! Para começar, cadastre sua escola.'
    end
  end
end
