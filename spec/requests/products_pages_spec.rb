require 'spec_helper'

describe "ProductsPages" do
  let(:product) { FactoryGirl.create(:product)}
  subject { page }
  before { visit root_path }
  describe "product should be displayed on the page" do
    it { should have_content(product.name) }
  end

  describe "it should have title Catalog" do
    it { should have_selector('title', text: "Catalog")}
  end

   describe "it should have filters" do
     it { should have_unchecked_field("checkbox") }
   end
end
