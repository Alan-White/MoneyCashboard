require_relative('../db/sql_runner')

class Transaction
  
  attr_accessor :value, :tag_id, :merchant_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i
    @value = options['value']
    @tag_id = options['tag_id'].to_i
    @merchant_id = options['merchant_id'].to_i
  end

  def save()
    sql = "INSERT INTO transactions (value, tag_id, merchant_id) VALUES ('#{@value}', #{@tag_id}, #{@merchant_id}) RETRNING *"
    result = SqlRunner..run(sql)
    id = result.first['id']
    @id = id
  end


end