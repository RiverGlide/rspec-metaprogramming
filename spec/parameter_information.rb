def nullary();end

RSpec::Matchers.define :satisfy_the_parameters_of do |expected|
  match do |actual|
    expected.parameters == actual
  end
end

describe "parameter matcher" do
  it "passes when two nullarys are the equivalent" do
    expect([]).to satisfy_the_parameters_of(method(:nullary))
  end
end
