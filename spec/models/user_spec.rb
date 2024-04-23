require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:email)}
  it {should validate_uniqueness_of(:email)}
  

  it '#set_api_key' do
    user = create(:user, password: 'odell123', password_confirmation: 'odell123')
    api_key = user.set_api_key
    expect(user.api_key.length).to eq 64
  end
end
