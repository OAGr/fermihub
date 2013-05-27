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

  def |(other)
    Dis.|(self,other)
  end

  def to_dis
    self
  end

  def standard_error
    interval.to_f / mean.to_f
  end

  def percent_error
    100 * standard_error
  end

  def to_i
    @mean.to_i
  end

  def to_f
    @mean.to_f
  end

  def self.+(*items)
    return items[0].clone if (items.length == 1)

    items = Dis.make_dis(*items)
    means = items.map{|item| item.mean}
    total_mean = means.inject{|sum,i| sum + i}

    intervals = items.map{|item| item.interval}
    total_interval = intervals.inject{|sum,i| sum + i}

    Dis.new(total_mean,total_interval)
  end

  def self.*(*items)
    return items[0].clone if (items.length == 1)

    items = Dis.make_dis(*items)
    means = items.map{|item| item.mean}
    total_mean = means.inject{|sum,i| sum * i}

    errors = items.map{|item| item.standard_error}
    total_error = errors.inject{|sum,i| sum + i}
    total_interval = total_mean * total_error

    Dis.new(total_mean,total_interval)
  end

  def self.|(*items)
    return items[0].clone if (items.length == 1)

    items = Dis.make_dis(*items)

    intervals = items.map{|item| item.interval}
    total_interval = intervals.map{|interval| (interval.to_f ** -2)}.inject{|sum, i| sum + i}

    means = items.map{|item| item.mean.to_f * (item.interval.to_f ** -2)}
    total_mean = means.inject{|sum,i| sum + i} / total_interval

    final_interval = total_interval ** -(0.5)

    Dis.new(total_mean,final_interval)
  end

  def self.max(*items)
    return items[0].clone if (items.length == 1)
    items = Dis.make_dis(*items)
    max = items.max_by { |d| d.mean }
    return max.clone
  end

  def self.min(*items)
    return items[0].clone if (items.length == 1)
    items = Dis.make_dis(*items)
    min = items.min_by { |d| d.mean }
    return min.clone
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
