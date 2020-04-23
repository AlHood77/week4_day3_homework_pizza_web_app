require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )

# import pizza order field
require_relative('./models/pizza_order')
also_reload('./models/*')

# -READ-

# INDEX - list all pizza orders

get '/pizza-orders' do
    @orders = PizzaOrder.all()
    erb(:index)
end

# NEW - display form to enter order information

get '/pizza-orders/new' do
    erb(:new)
end

# SHOW - display a single order

get '/pizza-orders/:id' do
    id = params[:id].to_i
    @order = PizzaOrder.find(id)
    erb(:show)
end


# CREATE - submit new order details

post '/pizza-orders' do
    @order = PizzaOrder.new(params)
    @order.save()
    erb(:create)
end



# EDIT - display form to edit details

get '/pizza-orders/:id/edit' do
    @order = PizzaOrder.find(params[:id])
    erb(:edit)
end

# UPDATE - submit amended details

post '/pizza-orders/:id' do # update
    PizzaOrder.new( params ).update
    redirect to '/pizza-orders'
end


# DELETE - remover order from database

post '/pizza-orders/:id/delete' do # delete
    order = PizzaOrder.find( params[:id] )
    order.delete()
    redirect to '/pizza-orders'
end