class OrderController < Sinatra::Base
	
	# sets root as the parent-directory of the current file
  	set :root, File.join(File.dirname(__FILE__), '..')
  
  	# sets the view directory correctly
  	set :views, Proc.new { File.join(root, "views") } 

  	configure :development do
      	register Sinatra::Reloader
  	end

  	get '/' do
  		@title = "Order List"
  		@orders = Order.all
  		erb :'orders/index'
  	end

  	get '/new' do
  		@title = "New Burger"
  		@order = Order.new
    	@order.id = ""
  		erb :'orders/new'
  	end

  	post '/' do
    
	    order = Order.new
	    order.temp = params[:temp]
	    order.size = params[:size]
	    top = params[:topping].join(',')
	    toppings = "{#{top}}"
	    order.toppings = toppings

	    order.save

	    redirect '/'

	end

  	get '/:id' do
  		id = params[:id].to_i
  		@title = id
  		@order = Order.grab id
  		erb :'orders/show'
  	end

  	get '/:id/edit' do
  		id = params[:id].to_i
    	@order = Order.grab id
    	erb :'orders/edit'
	end

	put '/:id'  do
    
	    id = params[:id].to_i
	    top = params[:topping].join(',')
		toppings = "{#{top}}"
	    @order = Order.update(id, params[:temp], params[:size], toppings) 
	    redirect '/'

  	end

  	delete '/:id' do
  		id = params[:id].to_i
    	Order.delete id
    	redirect '/'
    end

end