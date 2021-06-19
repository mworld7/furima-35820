FactoryBot.define do
  factory :item do
    title             {'test'}
    price             {1000}
    description       {'testtesttest'}
    category_id       {2} #'メンズ'
    condition_id      {2} #'新品・未使用'
    postage_by_id     {2} #'着払い(購入者負担)'
    ship_from_id      {2} #'北海道'
    shipping_date_id  {2} #'1~2日で発送'
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
