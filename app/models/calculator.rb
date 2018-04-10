class Calculator < ApplicationRecord
  validates_presence_of :expression, :result
  
  def calculate
    @operators = self.expression.scan(/[\*\/\+\-]/)
    @operands = self.expression.split(/[\*\/\+\-]/)
    order_of_operations = ['*', '/', '+', '-']

    while @operands.length > 1
      order_of_operations.each do |operator|
        while @operators.include? operator
          operator_index = @operators.index(operator)
          evaluate(operator, operator_index)
        end
      end
    end
    self.result = @operands.first
  end

  def remove_elements(operator_index)
    @operands.delete_at(operator_index + 1)
    @operators.delete_at(operator_index)
  end

  def evaluate(operator, operator_index)
    case operator
      when '*'
        result = multiply(@operands[operator_index], @operands[operator_index + 1])
        @operands[operator_index] = result
        remove_elements(operator_index)
      when '/'
        result = divide(@operands[operator_index], @operands[operator_index + 1])
        @operands[operator_index] = result
        remove_elements(operator_index)
      when '+'
        result = add(@operands[operator_index], @operands[operator_index + 1])
        @operands[operator_index] = result
        remove_elements(operator_index)
      when '-'
        result = subtract(@operands[operator_index], @operands[operator_index + 1])
        @operands[operator_index] = result
        remove_elements(operator_index)
    end
  end

  def multiply(a, b)
    ('%.2f' % (a.to_f * b.to_f)).to_s
  end

  def divide(a, b)
    ('%.2f' % (a.to_f / b.to_f)).to_s
  end

  def add(a, b)
    ('%.2f' % (a.to_f + b.to_f)).to_s
  end

  def subtract(a, b)
    ('%.2f' % (a.to_f - b.to_f)).to_s
  end
end
