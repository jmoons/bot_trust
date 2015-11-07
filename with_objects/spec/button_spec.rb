require_relative '../button'

describe "#Button" do

  before :each do
    @button_name  = 10
    @button       = Button.new(@button_name)
  end

  it "has a readable name" do
    expect(@button.name).to eq(@button_name)
  end

  it "will accept a string for #name, but will cast to int before persisting" do
    test_button = Button.new(@button_name.to_s)
    expect(test_button.name).to eq(@button_name)
  end
end