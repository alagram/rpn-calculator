require "stack"

def factorial(n)
  result = 1

  n.downto(1) do |i|
    result *= i
  end

  result
end

class RPNExpression
  # Returns an object representing the supplied RPN expression
  #
  # @param expr [String] an RPN expression, e.g., "5 4 +"
  def initialize(expr)
    @expr = expr
  end

  # Evaluates the underlying RPN expression and returns the final result as a
  # number.
  #
  # @return [Numeric] the evaluated RPN expression
  def evaluate
    stack = Stack.new

    tokens.each do |token|
      if numeric?(token)
        stack.push(token.to_i)
      elsif token == "+"
        rhs = stack.pop
        lhs = stack.pop
        stack.push(lhs + rhs)
      elsif token == "*"
        rhs = stack.pop
        lhs = stack.pop
        stack.push(lhs * rhs)
      elsif token == "-"
        rhs = stack.pop
        lhs = stack.pop
        stack.push(lhs - rhs)
      elsif token == "/"
        rhs = stack.pop
        lhs = stack.pop
        stack.push(lhs / rhs)
      elsif token == "^"
        rhs = stack.pop
        lhs = stack.pop
        stack.push(lhs ** rhs)
      elsif token == "%"
        rhs = stack.pop
        lhs = stack.pop
        stack.push(lhs % rhs)
      elsif token == "max"
        rhs = stack.pop
        lhs = stack.pop
        stack.push([lhs, rhs].max)
      elsif token == "min"
        rhs = stack.pop
        lhs = stack.pop
        stack.push([lhs, rhs].min)
      elsif token == "rand"
        rhs = stack.pop
        lhs = stack.pop
        stack.push(rand(lhs..rhs))
      elsif token == "sample"
        rhs = stack.pop
        lhs = stack.pop
        stack.push([lhs, rhs].sample)
      elsif token == "!"
        num = stack.pop
        stack.push(factorial(num))
      else
        raise "omg what is this token?"
      end
    end

    stack.pop
  end

  private

  def tokens
    @expr.split(" ")
  end

  def numeric?(token)
    token =~ /^-?\d+$/
  end

  def operator?(token)
    ["+", "*", "-"].include?(token)
  end
end
