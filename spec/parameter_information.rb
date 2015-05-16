def nullary();end
def required_position(one);end
def optional_position(one=nil);end

RSpec::Matchers.define :satisfy_the_definition_of do |method|
  match do |arguments|
    required_positional_parameters = method.parameters.select { |p| p.first == :req }.count
    optional_positional_parameters = method.parameters.select { |p| p.first == :opt }.count
    min_positional_parameters = required_positional_parameters
    max_positional_parameters = required_positional_parameters + optional_positional_parameters

    (min_positional_parameters..max_positional_parameters).include? arguments.count
  end

  failure_message do |arguments|
    "expected that #{arguments} would match the definition of the method `#{method.name}`: \n#{method.parameters}"
  end

  failure_message_when_negated do |arguments|
    "expected that #{arguments} would not match the definition of the method `#{method.name}`: \n#{method.parameters}"
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

  it "matches on a single parameter and an optional positional parameter" do
    a_single_parameter = [""]
    expect(a_single_parameter).to satisfy_the_definition_of(method(:optional_position))
  end

end
