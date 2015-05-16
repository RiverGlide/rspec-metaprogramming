def nullary();end
def required_position(one);end
def optional_position(one=nil);end

RSpec::Matchers.define :satisfy_the_definition_of do |expected|
  match do |actual|
    required_positional_parameters = expected.parameters.select { |p| p.first == :req }.count
    actual.count == required_positional_parameters
    #count up the number of positional parameters and subtract the number of optional parameters
    #(required)..(required + optional)
  end

  failure_message do |actual|
    "expected that #{actual} would match the definition of the method `#{expected.name}`: \n#{expected.parameters}"
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} would not match the definition of the method `#{expected.name}`: \n#{expected.parameters}"
  end

  # description when they don't match
  # expected parameter list to have 1..2 positional parameters, required keyword parameters [...] and optional keyword [...]
  # but actually contained 3 positional and missing required and additional unknown keywords
end

describe "parameter matcher" do
  it "matches on an empty parameter list and a nullary" do
    empty_parameter_list = []
    expect(empty_parameter_list).to satisfy_the_definition_of(method(:nullary))
  end

  it "matches on an empty parameter list and an optional positional parameter" do
    empty_parameter_list = []
    expect(empty_parameter_list).to satisfy_the_definition_of(method(:optional_position))
  end

  it "doesn't match on an empty parameter list and a method with a required positional parameter" do
    empty_parameter_list = []
    expect(empty_parameter_list).not_to satisfy_the_definition_of(method(:required_position))
  end
end
