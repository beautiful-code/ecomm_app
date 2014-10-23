# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  address    :string(255)
#  status     :string(255)      default("Initiated")
#  amount     :integer          default(0)
#

require 'spec_helper'

describe Order do
  let(:user)  { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order,:user => user ) }

  subject { order }
  it { should respond_to(:id) }
  it { should respond_to(:user_id) }

  describe "if user id is not present" do
    before { order.user_id ="" }
    it{ should_not be_valid }
  end
end
