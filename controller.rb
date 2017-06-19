require('sinatra')
require('sinatra/contrib/all')
require_relative('./models/transaction.rb')
require_relative('./models/tag.rb')
require_relative('./models/merchant.rb')

get '/transactions' do
  @transactions = Transaction.all
  erb(:index)
end

post "/transactions" do
  @transaction = Transaction.new(params)
  @transaction.save()
  erb(:create)
end

get '/transactions/new' do
  @tags = Tag.all
  @merchants = Merchant.all
  erb(:new)
end
# ------------------------------------------

get "/transactions/:id/edit" do
  @transaction = Transaction.find((params)["id"].to_i)
  @tags = Tag.all
  @merchants = Merchant.all
  erb(:edit)
end

post "/transactions/:id" do
  transaction = Transaction.new(params)
  transaction.update()
  redirect to("/transactions")
end

# ------------------------------------------

post "/transactions/:id/delete" do
  transaction = Transaction.find(params["id"].to_i)
  transaction.delete()
  redirect to("/transactions")
end