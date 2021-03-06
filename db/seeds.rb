require_relative('../models/Tag.rb')
require_relative('../models/Merchant.rb')
require_relative('../models/Transaction.rb')
require("pry")


Transaction.delete_all()
Tag.delete_all()
Merchant.delete_all()

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

transaction1 = Transaction.new({
  "date" => '2017-03-01',
  "value" => 50.67,
  "tag_id" => tag1.id,
  "merchant_id" => merchant1.id
  })
transaction2 = Transaction.new({
  "date" => '2017-04-01',
  "value" => 42.75,
  "tag_id" => tag2.id,
  "merchant_id" => merchant2.id
  })
transaction3 = Transaction.new({
  "date" => '2017-05-01',
  "value" => 15.02,
  "tag_id" => tag3.id,
  "merchant_id" => merchant3.id
  })
transaction4 = Transaction.new({
  "date" => '2017-06-01',
  "value" => 8.09,
  "tag_id" => tag1.id,
  "merchant_id" => merchant1.id
  })
transaction5 = Transaction.new({
  "date" => '2017-06-07',
  "value" => 1500.00,
  "tag_id" => tag4.id,
  "merchant_id" => merchant4.id
  })
transaction1.save()
transaction2.save()
transaction3.save()
transaction4.save()
transaction5.save()

binding.pry
nil