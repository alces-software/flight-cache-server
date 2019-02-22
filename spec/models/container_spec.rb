require 'rails_helper'

RSpec.describe Container, type: :model do
  it 'is valid' do
    expect(build(:container)).to be_valid
  end

  describe '#bucket' do
    it 'has a default bucket' do
      bucket = 'my-test-bucket'
      allow(Figaro.env).to receive(:default_bucket).and_return(bucket)
      expect(build(:container, bucket: nil).bucket).to eq(bucket)
    end

    it 'can not be an empty string' do
      expect(build(:container, bucket: '')).not_to be_valid
    end
  end
end
