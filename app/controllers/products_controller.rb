class ProductsController < ApplicationController
  def index
    @products = Product.all
    render :json => @products.to_json, :callback => params['callback']
    # render json: @products, :callback => params[:callback]
    # response = params[:callback] + '('+ @products.to_json + ')'
    # render :text => response
  end
  def new
  end
  def show
    @product = Product.find(params[:id])
  end
  def create
    # render plain: params[:product].inspect
      @product = Product.new(params.require(:product).permit(:title, :text))
      # @product = Product.new(params[:product])
      @product.save
      redirect_to @product
  end
end
