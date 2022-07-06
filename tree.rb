class Node

  @@operators_map = 
    {
      "x" => :*,
      "÷" => :/,
      "-" => :-,
      "+" => :+
    }

  def initialize(operator, left, right)
    @operator  = operator 
    @left = left
    @right = right
  end

  def result
    left = @left.is_a?(Integer) ? @left: @left.result 
    right = @right.is_a?(Integer) ? @right: @right.result 
    left.send(@@operators_map[@operator], right)
  end

  def to_s
    "(#{@left.to_s} #{@operator} #{@right.to_s})"
  end
end

tree = 
  Node.new(
    "÷", 
    Node.new(
      "+",
      7,
      Node.new(
        "x",
        Node.new(
          "-",
          3,
          2
        ),
        5
      ),
    ), 
    6
  )

def assert_equal(expected, actual)
  if expected != actual
    puts "Expected: #{expected.inspect}, got: #{actual.inspect}"
    exit 1
  end
end

assert_equal "((7 + ((3 - 2) x 5)) ÷ 6)", tree.to_s
assert_equal 2, tree.result