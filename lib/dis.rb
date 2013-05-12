class Dis
  attr_accessor :mean, :interval, :wideness, :parent

  def initialize(mean = nil, interval = 0, parent = nil)
    @mean = mean
    @interval = interval
    @parent = parent
    @confidence = 95
  end

  def +(other)
    Dis.+(self, other)
  end

  def *(other)
    Dis.*(self,other)
  end

  def to_dis
    self
  end

  def to_i
    @mean.to_i
  end

  def self.+(*items)
    items = Dis.make_dis(*items)
    means = items.map{|item| item.mean}
    total_mean = means.inject{|sum,i| sum + i}

    intervals = items.map{|item| item.interval}
    total_interval = intervals.inject{|sum,i| sum + i}

    Dis.new(total_mean,total_interval)
  end

  def self.*(*items)
    items = Dis.make_dis(*items)
    means = items.map{|item| item.mean}
    total_mean = means.inject{|sum,i| sum * i}

    intervals = items.map{|item| item.interval}
    total_interval = intervals.inject{|sum,i| sum * i}

    Dis.new(total_mean,total_interval)
  end

  def self.make_dis(*items)
    items.map! do |item|
      case item
      when Dis, Fixnum, Float
        item.to_dis
      else
        raise "Bad Type #{item}"
      end
    end
    items.count == 1 ? items[0] : items
  end
end

class Fixnum
  def to_dis
    Dis.new(self,0)
  end
end

class Float
  def to_dis
    Dis.new(self,0)
  end
end
