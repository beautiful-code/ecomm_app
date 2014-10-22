# == Schema Information
#
# Table name: products
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :string(255)
#  units        :integer
#  cost         :integer
#  manufacturer :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :string(255)
#

require 'spec_helper'

describe Product do

  let(:product) { FactoryGirl.create(:product) }

  subject { product }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:units) }
  it { should respond_to(:cost) }
  it { should respond_to(:manufacturer) }

  describe "when name is empty" do
    before{ product.name = " " }
    it{ should_not be_valid }
  end

  describe "when description is empty" do
    before { product.description = " " }
    it { should_not be_valid }
  end

  describe "when units is empty" do
    before { product.units = " " }
    it { should_not be_valid }
  end

  describe "when cost is empty" do
    before { product.cost = " " }
    it { should_not be_valid }
  end

  describe "when manufacturer is empty" do
    before { product.manufacturer = " " }
    it { should_not be_valid }
  end


end
