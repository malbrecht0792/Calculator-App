class CalculatorsController < ApplicationController
  def show
    @calculator = Calculator.find(params[:id])
  end
  
  def new
    @calculator = Calculator.new
  end
  
  def create
    @calculator = Calculator.new(calculator_params)
    @calculator.calculate

    if @calculator.save
      redirect_to @calculator
    else
      render 'new'
    end
  end

  def calculator_params
    params.require(:calculator).permit(:expression)
  end
end
