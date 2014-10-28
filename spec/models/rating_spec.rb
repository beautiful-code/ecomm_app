# == Schema Information
#
# Table name: ratings
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  product_id   :integer
#  rating_value :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Rating do
  let(:user) { FactoryGirl.create(:user) }
  let(:product) { FactoryGirl.create(:product) }
  let(:rating) { FactoryGirl.create(:rating,user: user, product: product) }

  subject { rating }

  describe "If it is not associated with any user" do
    before { rating.user_id = "" }
    it { should_not be_valid }
  end

  describe "if it is not associated with any product" do
    before { rating.product_id = "" }
    it { should_not be_valid }
  end

  describe "if it is not having any rating value" do
    before { rating.rating_value = "" }
    it { should_not be_valid }
  end
end
