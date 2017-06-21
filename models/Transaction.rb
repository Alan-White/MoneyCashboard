require_relative('../db/sql_runner')
require_relative('tag.rb')
require_relative('merchant.rb')
require ('pry-byebug')


class Transaction
  
  attr_accessor :date, :value, :tag_id, :merchant_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i
    # binding.pry
    @date = options['date']
    @value = options['value'].to_f
    @tag_id = options['tag_id'].to_i
    @merchant_id = options['merchant_id'].to_i
  end

  def tag()
    sql = "SELECT * FROM tags WHERE id = #{@tag_id}"
    tag = SqlRunner.run(sql)
    result = Tag.new(tag.first)
    return result
  end

  def merchant()
    sql = "SELECT * FROM merchants WHERE id = #{@merchant_id}"
    merchant = SqlRunner.run(sql)
    result = Merchant.new(merchant.first)
    return result
  end

  def save()
    sql = "INSERT INTO transactions (date, value, tag_id, merchant_id) VALUES ('#{@date}', #{@value*100}, #{@tag_id}, #{@merchant_id}) RETURNING *"
    result = SqlRunner.run(sql)
    id = result.first['id'].to_i
    @id = id
  end

  def update()
    sql = "UPDATE transactions SET (date, value, tag_id, merchant_id) = ('#{@date}', #{@value*100}, #{@tag_id}, #{@merchant_id} )WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM transactions WHERE id=#{ @id };"
    SqlRunner.run( sql )
  end

  def self.find( id )
    sql = "SELECT * FROM transactions WHERE id=#{id};"
    transaction = SqlRunner.run( sql )
    result = Transaction.new( transaction.first )
    return result
  end


  # def self.all()
  #   sql = "SELECT * FROM transactions"
  #   SqlRunner.run(sql).map {|transaction| Transaction.new(transaction)}
  # end

  def self.all
    sql = "SELECT * FROM transactions"
    transactions = map_transactions(sql)
    return transactions
  end 

  def self.map_transactions(sql)
    transactions = SqlRunner.run(sql)
    return transactions.map { |transaction| Transaction.new(transaction) }
  end
#----------------------------------------------
# BELOW: need to find total cost of all transactions.
  def self.total_spent()
   all_values = Transaction.all
     return all_values.sum{|orange| orange.value}
    end

# This was Alan's attempt which returned 
# => [{"value"=>"5067"}, {"value"=>"4275"}, {"value"=>"1502"}, {"value"=>"809"}]
  # def self.total_spent()
  # sql = "SELECT value FROM transactions"
  #   all_values = SqlRunner.run(sql).select {|transaction| Transaction.new(transaction)}
  #   return all_values
  #  end

#---------------------------------------------

  def self.total_tag_spend(tag_id)
   sql = "SELECT value FROM transactions WHERE tag_id = #{tag_id}"
     all_values = SqlRunner.run(sql).map {|banana| Transaction.new(banana)}
     return all_values.sum{|banana| banana.value}
    end

# Below is Alan's attempt which didn't work.
    # def self.total_tag_spend()
    #  sql = "SELECT value FROM transactions WHERE tag_id = tag.id"
    #    all_values = SqlRunner.run(sql).select {|transaction| Transaction.new(transaction)}
    #    return all_values
    #   end
#--------------------------------------------



end