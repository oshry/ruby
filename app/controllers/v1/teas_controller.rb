module V1
  class TeasController < ApplicationController
    def index
      @teas = Teastore.all
      render :json => @teas.to_json, :callback => params['callback']
      # render json: @teas, :callback => params[:callback]
      # response = params[:callback] + '('+ @products.to_json + ')'
      # render @teas
    end

    def new
    end

    def edit
      @tea = Teastore.find(params[:id])
    end

    def update
      @tea = Teastore.find(params[:id])

      if @tea.update(tea_params)
        redirect_to @tea
      else
        render 'edit'
      end
    end

    def show
      @tea = Teastore.find(params[:id])
      render :json => @tea.to_json, :callback => params['callback']
    end
    def create
      # render plain: params[:product].inspect
      @tea = Teastore.new(params.require(:tea).permit(:name, :description, :thumb, :price))
      # @product = Product.new(params[:product])
      @tea.save
      redirect_to @tea
    end
    private
    def tea_params
      params.require(:tea).permit(:name, :description, :thumb, :price)
    end
  end
end
