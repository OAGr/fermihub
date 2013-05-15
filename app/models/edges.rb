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
        edges << Edge.new("O#{operation.id}","I#{distribution.id}")
      end
      operation.dependent do |distribution|
        edges << Edge.new("I#{distribution.id}", "O#{operation.id}" )
      end
    end
    edges
  end

end
