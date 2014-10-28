# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  product_id :integer
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string(255)
#

require 'spec_helper'

describe Review do
  let(:user) { FactoryGirl.create(:user) }
  let(:product) { FactoryGirl.create(:product) }
  let(:review) { FactoryGirl.create(:review) }

  subject { review }

  describe "if it doesn't have any content" do
    before { review.content = "" }
    it { should_not be_valid }
  end

  describe "if it is not associated to a user id" do
    before { review.user_id = "" }
    it  { should_not be_valid }
  end

  describe "if it is not associated with any product" do
    before { review.product_id = "" }
    it { should_not be_valid }
  end

  describe "if title is empty" do
    before { review.title = '' }
    it { should_not be_valid }
  end
end

