FactoryBot.define do
  factory :purchaser_address do
    post_code { '123-4567' }
    ship_from_id { 2 }
    city { '生駒市' }
    street { '東松ヶ丘1-1' }
    building { 'メゾンウエダ' }
    phone { '12312345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
