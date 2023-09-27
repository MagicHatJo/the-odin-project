module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    for element in self do
      yield element
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    i = 0
    for element in self do
      yield element, i
      i += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    out = []
    my_each { |element| out << element if yield element }
    return out
  end

  def my_all?(other = nil)
    check = block_given? ?
            ->(element) { yield element } :
            ->(element) { other === element }
    my_each { |element| return false unless check.call(element) }
    return true
  end

  def my_any?(other = nil)
    check = block_given? ?
            ->(element) { yield element } :
            ->(element) { other === element }
    my_each { |element| return true if check.call(element) }
    return false
  end

  def my_none?(other = nil)
    check = block_given? ?
            ->(element) { yield element } :
            ->(element) { other === element }
    my_each { |element| return false if check.call(element) }
    return true
  end

  def my_count(other = nil)
    return length if other.nil? && !block_given?
    check = block_given? ?
            ->(element) { yield element } :
            ->(element) { other === element }
    i = 0
    my_each { |element| i += 1 if check.call(element) }
    return i
  end

  def my_map(other = nil)
    out = []
    return out if other.nil? && !block_given?
    check = block_given? ?
            ->(element) { yield element } :
            ->(element) { other === element }
    my_each { |element| out << check.call(element) }
    return out
  end

  def my_inject(other = nil, &block)
    out = other
    my_each_with_index do |element, i|
      out = out.nil? && i.zero? ? element : block.call(out, element)
      i += 1
    end
    out
  end
end