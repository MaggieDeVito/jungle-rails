require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
   # SETUP
   before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

    scenario "They can navigate from home page to product detail page" do
      visit root_path

      find('article.product:first-child').find('footer.actions').click_on 'Details'

      expect(page).to have_css 'article.product-detail', count: 1
    end
end

