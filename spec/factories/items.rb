FactoryBot.define do
  factory :item do
    title             { 'test' }
    price             { 1000 }
    description       { 'testtesttest' }
    category_id       { 2 }
    condition_id      { 2 }
    postage_by_id     { 2 }
    ship_from_id      { 2 }
    shipping_date_id  { 2 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
