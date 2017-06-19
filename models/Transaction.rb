require_relative('../db/sql_runner')

class Transaction
  
  attr_accessor :value, :tag_id, :merchant_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i
    @value = options['value'].to_i
    @tag_id = options['tag_id'].to_i
    @merchant_id = options['merchant_id'].to_i
  end

  def save()
    sql = "INSERT INTO transactions (value, tag_id, merchant_id) VALUES (#{@value}, #{@tag_id}, #{@merchant_id}) RETURNING *"
    result = SqlRunner.run(sql)
    id = result.first['id'].to_i
    @id = id
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
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

  # BELOW: need to find total cost of transactions by tag.
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
end