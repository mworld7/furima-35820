require 'rails_helper'

RSpec.describe PurchaserAddress, type: :model do
  describe '配送先情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchaser_address = FactoryBot.build(:purchaser_address, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchaser_address).to be_valid
      end

      it 'buildingは空でも保存できること' do
        @purchaser_address.building = ''
        expect(@purchaser_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が必須であること' do
        @purchaser_address.post_code = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('郵便番号を入力してください')
      end
      it '郵便番号は、「3桁ハイフン4桁」の全角文字列では登録できない' do
        @purchaser_address.post_code = '１２３ー４５６７'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('郵便番号は - を含む半角文字列を使用してください')
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角英字では登録できない' do
        @purchaser_address.post_code = 'aaa-bbbb'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('郵便番号は - を含む半角文字列を使用してください')
      end
      it '郵便番号は、ハイフンなしでは登録できない' do
        @purchaser_address.post_code = '1234567'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('郵便番号は - を含む半角文字列を使用してください')
      end
      it '郵便番号は、「3桁ハイフン4桁」以外のの半角文字列では登録できない' do
        @purchaser_address.post_code = '1234-567'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('郵便番号は - を含む半角文字列を使用してください')
      end
      it '都道府県が必須であること' do
        @purchaser_address.ship_from_id = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('都道府県を選んでください')
      end
      it '都道府県が、(---) では登録できない' do
        @purchaser_address.ship_from_id = 1
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('都道府県を選んでください')
      end
      it '市区町村が必須であること' do
        @purchaser_address.city = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('市区町村を入力してください')
      end
      it '番地が必須であること' do
        @purchaser_address.street = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('番地を入力してください')
      end
      it '電話番号が必須であること' do
        @purchaser_address.phone = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('電話番号を入力してください')
      end
      it '電話番号は、10桁以上11桁以内の全角数値では登録できない' do
        @purchaser_address.phone = '１２３１２３４５６７８'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値のみを使用してください')
      end
      it '電話番号は、10桁以上11桁以内の文字では登録できない' do
        @purchaser_address.phone = 'abcdefghijk'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値のみを使用してください')
      end
      it '電話番号は、10桁以上11桁以内の半角数値にハイフンを含むとでは登録できない' do
        @purchaser_address.phone = '123-1234-5678'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値のみを使用してください')
      end
      it '電話番号は、９桁以内の半角数値では登録できない' do
        @purchaser_address.phone = '123123456'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値のみを使用してください')
      end
      it '電話番号は、12桁以上の半角数値では登録できない' do
        @purchaser_address.phone = '123123456789'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値のみを使用してください')
      end
      it 'tokenが空では登録できないこと' do
        @purchaser_address.token = nil
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('クレジットカード情報を入力してください')
      end
      it 'ユーザーが空では登録できないこと' do
        @purchaser_address.user_id = nil
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('Userを入力してください')
      end
      it '商品が空では登録できないこと' do
        @purchaser_address.item_id = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
