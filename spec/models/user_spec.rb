# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  address         :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean
#

require 'spec_helper'

describe "User model" do
  let(:user) { FactoryGirl.create(:user) }

  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:address)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "name is null" do
    before { user.name =" " }
    it { should_not be_valid }
  end

  describe "email is null" do
    before { user.email = " " }
    it { should_not be_valid }
  end

  describe "address is null" do
    before { user.address = "" }
    it { should_not be_valid }
  end

  describe "invalid email address" do

    describe "no '@' symbol" do
      before{ user.email = "somethingat_rategmail.com" }
      it { should_not be_valid }
    end

    describe "no domain name" do
      before { user.email = "something@" }
      it { should_not be_valid }
    end
  end

  describe "valid email address" do

    describe "all capital letters" do
      before { user.email= "SOMETING@GMAIL.COM"}
      it { should be_valid }
    end

    describe "camel case letters" do
      before { user.email = "SoMeThInG@GMaiL.COm"}
      it { should be_valid }
    end

    describe "all small letters" do
      before { user.email = "something@exapmle.com"}
      it { should be_valid }
    end
  end

  describe "invalid address" do

    describe "too short" do
      before { user.address = "a" }
      it { should_not be_valid }
    end

    describe "too long" do
      before { user.address = "a"*31 }
      it { should_not be_valid }
    end
  end

  describe "password is not present" do
    before { user.password = user.password_confirmation = "" }
    it { should_not be_valid }
  end

  describe "password and confirm_password do not match" do
    before { user.password ="abcdefg" }
    it { should_not be_valid }
  end

  describe "password length is less then 6" do
    before { user.password = user.password_confirmation = "a"}
    it { should_not be_valid }
  end
end
