class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def show
    @foods = Food.all
  end
end
