class Edge
  attr_accessor :source, :target, :left, :right

  def initialize(source, target)
    @source = source
    @target = target
    @left = false
    @right = true
  end

  def self.all(model_id = nil)
    if model_id
      model = Model.find(model_id)
      operations = model.operations
    else
      operations = Operation.all
    end
    edges = []
    operations.each do |operation|
      edges << Edge.new("O#{operation.id}", "D#{operation.dependent.id}")
      operation.inputs.each do |d1|
        edges << Edge.new( "D#{d1.id}", "O#{operation.id}")
      end
    end
    edges
  end

end
