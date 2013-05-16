class Node
  attr_accessor :id, :name, :mean, :spread, :klass, :type, :reflexive

  def initialize(id, name, klass = nil, mean = nil, spread = nil, type = nil)
    @id = id
    #@name = name
    #@klass = klass
    #@mean = mean
    #@spread = spread
    #@type = type
    #@reflexive = false
  end

  def self.all
    nodes = Distribution.all.map {|d| Node.new(d.id, d.name, 'D', d.mean, d.spread,d.type)}
    nodes += Operation.all.map {|d| Node.new((d.id + 10000),d.operator, 'O')}
    return nodes
  end

end
