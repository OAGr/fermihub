class Independent < Distribution
  attr_accessible :name, :mean, :spread, :wideness

  def awesome
    'this is cool!'
  end

end
