class Dependent < Distribution
  attr_accessible :name, :mean, :spread, :wideness, :operation_id
  belongs_to :operation, :dependent => :destroy
  before_create :check_operation
  validates_uniqueness_of :operation_id, message: "operator already has dependent distribution"
  validates :operation_id, :presence => true
  validates_presence_of :operation

  def from_dis(dis)
    self.update_attributes(mean: dis.mean, spread: dis.interval)
  end

  def check_operation
    unless operation
      self.operation = Operation.create
    end
  end
end
