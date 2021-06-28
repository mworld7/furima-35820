require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品登録' do
    context '商品出品登録ができる時' do
      it 'title、price、description、category_id、condition_id、postage_by_id、ship_from_id、shipping_date_id、が存在すれば登録できること' do
        expect(@item).to be_valid
      end
    end

    context '商品出品登録ができない時' do
      it '商品画像が必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end

      it '商品名が必須であること' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it '商品の説明が必須であること' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'カテゴリーが必須であること' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選んでください")
      end

      it '商品の状態が必須であること' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選んでください")
      end

      it '配送料の負担が必須であること' do
        @item.postage_by_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選んでください")
      end

      it '発送元の地域が必須であること' do
        @item.ship_from_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選んでください")
      end

      it '発送までの日数が必須であること' do
        @item.shipping_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選んでください")
      end

      it '販売価格が必須であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end

      it 'カテゴリーは、(---) では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選んでください')
      end

      it '商品の状態は、(---)では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選んでください')
      end

      it '配送料の負担は、(---)では登録できない' do
        @item.postage_by_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選んでください')
      end

      it '発送元の地域は、(---)では登録できない' do
        @item.ship_from_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選んでください')
      end

      it '発送までの日数は、(---)では登録できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選んでください')
      end

      it '値段は、300以下では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は300以上の値にしてください')
      end

      it '値段は、10000000以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は9999999以下の値にしてください')
      end

      it '値段は、半角英字では登録できない' do
        @item.price = 'aaaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は数値で入力してください')
      end

      it '値段は、全角数字では登録できない' do
        @item.price = '１２３４５'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は数値で入力してください')
      end

      it '値段は、半角英数混合では登録できない' do
        @item.price = '123abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は数値で入力してください')
      end
    end
  end
end
