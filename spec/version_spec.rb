require 'spec_helper'

describe PublicActivity, 'VERSION' do
  it 'is present' do
    PublicActivity::VERSION.should_not be_nil
  end
end
