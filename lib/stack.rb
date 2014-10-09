# An implementation of a Stack (abstract data type) in Ruby
# using an Array.

class Stack
  class UnderFlowError < StandardError;end

  def initialize
    @stack = []
  end

  def empty?
    @stack.empty?
  end

  def push(val)
    stack.push(val)
  end

  def pop
    raise UnderFlowError, "Stack is empty" if empty?
    @stack.pop
  end

  def peek
    @stack.last
  end
end
