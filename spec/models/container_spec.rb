require 'rails_helper'

RSpec.describe Container, type: :model do
  it 'is valid' do
    expect(build(:container)).to be_valid
  end
end
