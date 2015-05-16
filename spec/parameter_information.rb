def nullary();end
def one_required_positional(one);end
def one_optional_positional(one=nil);end

RSpec::Matchers.define :satisfy_the_definition_of do |method|
  match do |arguments|
    parameter_counts = method.parameters.reduce(Hash.new(initial_count = 0)) { |result, parameter| result[parameter.first] += 1; result }
    min_positional_parameters = parameter_counts[:req]
    max_positional_parameters = parameter_counts[:req] + parameter_counts[:opt]

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

describe "argument matcher" do
  it "matches on an empty argument list and a nullary" do
    empty_argument_list = []
    expect(empty_argument_list).to satisfy_the_definition_of(method(:nullary))
  end

  it "matches on an empty argument list and an optional positional parameter" do
    empty_argument_list = []
    expect(empty_argument_list).to satisfy_the_definition_of(method(:one_optional_positional))
  end

  it "doesn't match on an empty argument list and a method with a required positional parameter" do
    empty_argument_list = []
    expect(empty_argument_list).not_to satisfy_the_definition_of(method(:one_required_positional))
  end

  it "matches on a single argument and an optional positional parameter" do
    a_single_argument = [""]
    expect(a_single_argument).to satisfy_the_definition_of(method(:one_optional_positional))
  end

  it "matches on a single argument and a required positional parameter" do
    a_single_argument = [""]
    expect(a_single_argument).to satisfy_the_definition_of(method(:one_required_positional))
  end

  it "doesn't match on two arguments and a single required positional parameter" do
    two_arguments = ["", ""]
    expect(two_arguments).not_to satisfy_the_definition_of(method(:one_required_positional))
  end
end
