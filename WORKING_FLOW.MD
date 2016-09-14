general working flow
1. install ruby, rails, rubymine
2. install rack proxy - cors
3. create mvc 
4. adding versions: ref:[https://www.bignerdranch.com/blog/adding-versions-rails-api/]
5. add tea data and change controller output to json

details
1.  check that i have sqlite3(sqlite3 --version) and ruby(ruby -v)
2.  install rails -> https://trac.macports.org/wiki/howto/RubyOnRails
3.  rails getting start -> http://guides.rubyonrails.org/getting_started.html
4.  install rubymine
5.  Starting up the Web Server(puma) -> rails server -> page is in http://localhost:3000/
6.  create first controller -> rails generate controller Welcome index
7.  rails routes add "resources :products"
8.  rails generate controller Products
9. add action to controller   
        def new
        end
        def create
         render plain: params[:product].inspect // debug method = inspect
        end
10. add model -> rails generate model Product title:string text:text
11. run migration -> rails db:migrate (for production use: rails db:migrate RAILS_ENV=production)
12. add save method to create action in products controller -> 
         def create
             @product = Product.new(params[:product])
             @product.save
             redirect_to @product
         end 
13. which which parameters are allowed into our controller actions(security feature) ->
        change -> @product = Product.new(params[:product])
        to -> @product = Product.new(params.require(:product).permit(:title, :text))
    or
    def create
      @article = Article.new(article_params)
     
      @article.save
      redirect_to @article
    end
     
    private
      def article_params
        params.require(:article).permit(:title, :text)
      end
14. add show action:
      def show
          @product = Product.find(params[:id])
        end
        
15. configure rack proxy for cores -> [https://github.com/cyu/rack-cors]
    1. add "gem 'rack-cors', :require => 'rack/cors'" to Gemfile
    2. install rack-cores -> gem install rack-cors
    3. add to config.ru :
        require 'rack/cors'
        use Rack::Cors do
          allow do
            origins 'localhost:3000', '127.0.0.1:3000',
                    /\Ahttp:\/\/192\.168\.0\.\d{1,3}(:\d+)?\z/
        
            resource '/file/list_all/', :headers => 'x-domain-token'
            resource '/file/at/*',
                     :methods => [:get, :post, :delete, :put, :patch, :options, :head],
                     :headers => 'x-domain-token',
                     :expose  => ['Some-Custom-Response-Header'],
                     :max_age => 600
            # headers to expose
          end
        
          allow do
            origins '*'
            resource '/public/*', :headers => :any, :methods => :get
          end
        end
    4. add to application.rb :
        require 'rack/cors'
        config.middleware.insert_before 0, Rack::Cors do
              allow do
                origins '*'
                resource '*', :headers => :any, :methods => [:get, :post, :options]
              end
            end
    5. run proxy -> rackup config.ru

16. adding versions: ref:[https://www.bignerdranch.com/blog/adding-versions-rails-api/]
    1. create -> constraints/api_constraint.rb
read more:
1. routing -> http://guides.rubyonrails.org/routing.html
2. ruby language -> http://ruby-doc.com/docs/ProgrammingRuby/
3. migration -> http://edgeguides.rubyonrails.org/active_record_migrations.html
4.
