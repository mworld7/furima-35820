require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報/本人情報確認' do
    context 'ユーザー新規登録ができる時' do
      it 'email、passwordとpassword_confirmation、nickname、name、name_kana、birthday、が存在すれば登録できること' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザー新規登録ができない時' do
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'パスワードは、半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めてください')
      end

      it 'パスワードは、全角英字のみでは登録できない' do
        @user.password = 'AAAAAA'
        @user.password_confirmation = 'AAAAAA'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めてください')
      end

      it 'パスワードは、英字のみでは登録できない' do
        @user.password = 'aaaAAA'
        @user.password_confirmation = 'aaaAAA'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めてください')
      end

      it 'パスワードは、数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めてください')
      end

      it 'パスワードは、全角数字を含むとでは登録できない' do
        @user.password = 'aaa１２３'
        @user.password_confirmation = 'aaa１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めてください')
      end

      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'お名前(全角)は、名字が必須であること' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end

      it 'お名前(全角)は、名前が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it '名字(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.family_name = 'aa11'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字は全角文字を使用してください')
      end

      it '名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.first_name = 'aa11'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は全角文字を使用してください')
      end

      it 'お名前カナ(全角)は、名字が必須であること' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字カナを入力してください")
      end

      it 'お名前カナ(全角)は、名前が必須であること' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前カナを入力してください")
      end

      it '名字カナ(全角)は、英字での登録はできない。' do
        @user.family_name_kana = 'Test'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字カナは全角カタカナを使用してください')
      end

      it '名字カナ(全角)は、数字での登録はできない。' do
        @user.family_name_kana = '1111'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字カナは全角カタカナを使用してください')
      end

      it '名前カナ(全角)は、英字での登録はできない。' do
        @user.first_name_kana = 'Test'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前カナは全角カタカナを使用してください')
      end

      it '名前カナ(全角)は、数字での登録はできない。' do
        @user.first_name_kana = '1111'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前カナは全角カタカナを使用してください')
      end

      it '生年月日が必須であること' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
