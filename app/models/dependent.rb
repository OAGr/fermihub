class Dependent < Distribution
  attr_accessible :mean, :spread, :wideness
  belongs_to :operation
  after_create :check_operation

  def from_dis(dis)
    self.update_attributes(mean: dis.mean, spread: dis.interval)
  end

  def check_operation
    unless operation
      self.operation = Operation.create
    end
  end
end
