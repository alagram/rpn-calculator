require "stack"

def factorial(n)
  result = 1

  n.downto(1) do |i|
    result *= i
  end

  result
end

SYMBOL_TABLE = {
  "+" => lambda { |x, y| x + y },
  "*" => lambda { |x, y| x * y },
  "-" => lambda { |x, y| x - y },
  "!" => lambda { |n| factorial(n) },
  "%" => lambda { |x, y| x % y },
  "wiggle" => lambda { |x, y, z| x * y + z },
  "if" => lambda { |x, y, z| x == 0 ? y : z },
  ">" => lambda { |x, y| x > y ? 1 : 0 }
}

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
      elsif operator?(token)
        args = []
        SYMBOL_TABLE[token].arity.times do
          args.unshift(stack.pop)
        end

        stack.push(call_operator(token, *args))
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
    SYMBOL_TABLE.key?(token)
  end

  def call_operator(operator, *args)
    SYMBOL_TABLE[operator].call(*args)
  end
end
