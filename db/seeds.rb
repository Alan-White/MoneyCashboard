require_relative('../models/Tag.rb')
require_relative('../models/Merchant.rb')
require_relative('../models/Transaction.rb')
require("pry")

# do I need to delete these .delete_all calls after testing the app ????

tag1 = Tag.new({"name" => "food"})
tag2 = Tag.new({"name" => "social"})
tag3 = Tag.new({"name" => "transport"})
tag4 = Tag.new({"name" => "holiday"})
tag1.save()
tag2.save()
tag3.save()
tag4.save()

merchant1 = Merchant.new({"name" => "Sainsburys"})
merchant2 = Merchant.new({"name" => "The_Pub"})
merchant3 = Merchant.new({"name" => "The_Garage"})
merchant4 = Merchant.new({"name" => "Happy_Holidays"})
merchant1.save()
merchant2.save()
merchant3.save()
merchant4.save()

binding.pry




transaction1 = Transaction.new({

  })