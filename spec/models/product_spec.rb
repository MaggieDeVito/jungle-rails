require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "should successfully create a new product" do
      @category = Category.create(name: 'Electronics')
      @product = @category.products.create(name: 'Hotdog Slicer', description: 'test', image: 'test', price_cents: 10000, quantity: 10)
      expect(@product).to be_valid
      @product.errors.full_messages
    end

    it "should not be valid without a name" do
      @category = Category.create(name: 'Electronics')
      @product = @category.products.create(name: nil, description: 'test', image: 'test', price_cents: 10000, quantity: 10)
      expect(@product).not_to be_valid
      @product.errors.full_messages
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not be valid without a price" do
      @category = Category.create(name: 'Electronics')
      @product = @category.products.create(name: 'Hotdog Slicer', description: 'test', image: 'test', price_cents: nil, quantity: 10)
      expect(@product).not_to be_valid
      @product.errors.full_messages
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should not be valid without any quantity" do
      @category = Category.create(name: 'Electronics')
      @product = @category.products.create(name: 'Hotdog Slicer', description: 'test', image: 'test', price_cents: 10000, quantity: nil)
      expect(@product).not_to be_valid
      @product.errors.full_messages
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not be valid without a category" do
      @product = Product.create(name: 'Hotdog Slicer', description: 'test', image: 'test', price_cents: 10000, quantity: 10)
      expect(@product).not_to be_valid
      @product.errors.full_messages
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
