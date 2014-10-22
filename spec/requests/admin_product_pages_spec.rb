require 'spec_helper'

describe "Admin ProductPages" do

  subject { page }

  describe "edit product page" do
    let(:product) { FactoryGirl.create(:product) }
    let(:submit) { "Save changes" }
    before { visit edit_admin_product_path(product) }

    it { should have_selector('title',text: "Edit Product") }

    describe "with invalid information" do
      before { fill_in "Name", with: "" }
      it "should not change the product info" do
        expect { click_button submit }.not_to change(Product,:count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "new name"
        click_button submit
      end

      specify { product.reload.name.should == "new name" }
    end
  end

  describe "add new product page" do
    before { visit new_admin_product_path }

    let(:submit) { "Save changes" }

    describe "with invalid information" do
      it "should not create a new product" do
        expect { click_button submit }.not_to change(Product,:count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",       with: "Nexus 4"
        fill_in "Number of Units",    with: 4
        fill_in "Manufacturer",       with: "LG"
        fill_in "Price",              with: 23000
        fill_in "Description",        with: "stock android"
      end

      it "should create a new product" do
        expect { click_button submit }.to change(Product, :count).by(1)
      end
    end
  end

  describe "delete an existing product" do
    
  end
end

