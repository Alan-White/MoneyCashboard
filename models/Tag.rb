require_relative('../db/sql_runner')
require_relative('transaction.rb')

class Tag

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO tags (name) VALUES ('#{@name}') RETURNING *"
    result = SqlRunner.run(sql)
    id = result.first["id"]
    @id = id.to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    SqlRunner.run(sql)
  end

  # def self.all()
  #   sql = "SELECT * FROM tags"
  #   SqlRunner.run(sql).map {|tag| Merchant.new(tag)}
  # end

  def self.all
    sql = "SELECT * FROM tags"
    tags = map_tags(sql)
    return tags
  end 

  def self.map_tags(sql)
    tags = SqlRunner.run(sql)
    return tags.map { |tag| Tag.new(tag) }
  end

end