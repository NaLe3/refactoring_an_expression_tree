class Node

  @@operator_map = 
    {
      "x" => :*,
      "÷" => :/,
      "-" => :-,
      "+" => :+
    }
    
  def initialize(data, left, right)
    @data = data
    @left = left
    @right = right
  end

  def result
    return @data.to_f if @data.is_a?(Integer) 
    @left.result.send(@@operator_map[@data], @right.result)
  end

  def to_s
    return @data.to_s if @data.is_a?(Integer) 
    "(#{@left.to_s} #{@data} #{@right.to_s})"
  end
end

tree = 
  Node.new(
    "÷",
    Node.new(
      "+",
      Node.new(7, nil, nil),
      Node.new(
        "x",
        Node.new("-",
          Node.new(3, nil, nil),
          Node.new(2, nil, nil)
        ),
        Node.new(5, nil, nil)
      )
    ),
    Node.new(6, nil, nil)
  )

def assert_equal(expected, actual)
  if expected != actual
    puts "Expected: #{expected.inspect}, got: #{actual.inspect}"
    exit 1
  end
end

assert_equal "((7 + ((3 - 2) x 5)) ÷ 6)", tree.to_s
assert_equal 2, tree.result