require('sinatra')
require('sinatra/contrib/all')
require_relative('./models/transaction.rb')
require_relative('./models/tag.rb')
require_relative('./models/merchant.rb')

get '/transactions' do
  @transactions = Transaction.all
  erb(:index)
end

get '/transactions/new' do
  @tags = Tag.all
  @merchants = Merchant.all
  erb(:new)
end


post "/transactions" do
  @transaction = Transaction.new(params)
  @transaction.save()
  erb(:create)
end

