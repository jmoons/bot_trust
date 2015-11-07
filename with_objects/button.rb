class Button

  attr_reader :name

  def initialize(button_name)
    @name = button_name.to_i
  end

end