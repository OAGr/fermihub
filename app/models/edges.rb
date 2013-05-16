class Edge
  attr_accessor :source, :target, :left, :right

  def initialize(source, target)
    @source = source
    @target = target
    @left = false
    @right = true
  end

  def self.all
    edges = []
    Operation.all.each do |operation|
      operation.inputs.each do |distribution|
        edges << Edge.new( "D#{distribution.id}", "O#{operation.id}")
      end
      operation.dependent do |distribution|
        edges << Edge.new("O#{operation.id}", "D#{distribution.id}" )
      end
    end
    edges
  end

end
