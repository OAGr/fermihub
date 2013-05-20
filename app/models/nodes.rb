class Node
  attr_accessor :id, :name, :mean, :spread, :klass, :type, :reflexive

  def initialize(id, name, klass = nil, mean = nil, spread = nil, type = nil)
    @id = id
    @name = name
    @klass = klass
    @mean = mean
    @spread = spread
    @type = type
    @reflexive = false
  end

  def self.all(model_id = nil)
    if model_id
      model = Model.find(model_id)
      distributions = model.distributions
      operations = model.operations
    else
      distributions = Distribution.all
      operations = Operation.all
    end
    nodes = distributions.map {|d| Node.new("D#{d.id}", d.name, 'D', d.mean, d.spread,d.type)}
    nodes += operations.map {|d| Node.new("O#{d.id}" ,d.operator, 'O')}
    return nodes
  end

end
