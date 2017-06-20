require_relative('../db/sql_runner')
require_relative('transaction.rb')


class Merchant

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO merchants (name) VALUES ('#{@name}') RETURNING *"
    result = SqlRunner.run(sql)
    id = result.first["id"]
    @id = id.to_i
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

  # def self.all()
  #   sql = "SELECT * FROM merchants"
  #   SqlRunner.run(sql).map {|merchant| Merchant.new(merchant)}
  # end

  def self.all
    sql = "SELECT * FROM merchants"
    merchants = map_merchants(sql)
    return merchants
  end 

  def self.map_merchants(sql)
    merchants = SqlRunner.run(sql)
    return merchants.map { |merchant| Merchant.new(merchant) }
  end

end