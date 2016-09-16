require 'spec_helper'

describe Travisci::Bundle::Update::Pr do
  it 'has a version number' do
    expect(Travisci::Bundle::Update::Pr::VERSION).not_to be nil
  end

end
