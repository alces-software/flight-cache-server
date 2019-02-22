require 'rails_helper'

RSpec.describe Container, type: :model do
  it 'has a default bucket' do
    bucket = 'my-test-bucket'
    allow(Figaro.env).to receive(:default_bucket).and_return(bucket)
    expect(build(:container, bucket: nil).bucket).to eq(bucket)
  end
end
