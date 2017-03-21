require 'rails_helper'
RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:category) do
      Category.find_or_create_by!(name: 'Electronics')
    end
    let(:product) do
      category.products.create!(
        name:  'Optimal Sleeping Bed',
        description: Faker::Hipster.paragraph(1),
        quantity: 320,
        price: 3_052.00
      )
    end
    it 'is valid when created with valid attributes' do
      expect(product).to be_valid
    end
    it 'is not valid without a name' do
      product.name = ''
      product.valid?
      expect(product.errors.full_messages).to eq(["Name can't be blank"])
    end
    it 'is not valid without a price' do
      product.price = ''
      product.valid?
      expect(product.errors.full_messages).to eq(['Price is not a number'])
    end
    it 'is not valid without a quantity' do
      product.quantity = ''
      product.valid?
      expect(product.errors.full_messages).to eq(["Quantity can't be blank"])
    end
    it 'is not valid without a category' do
      product.category = nil
      product.valid?
      expect(product.errors.full_messages).to eq(["Category can't be blank"])
    end
  end
end
