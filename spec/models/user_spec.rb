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
        expect(@user.errors.full_messages).to include ("Nickname can't be blank")
      end

      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include ("Email can't be blank")
      end

      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include ("Email has already been taken")
      end

      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include ("Email is invalid")
      end

      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include ("Password can't be blank")
      end

      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードは、半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
       expect(@user.errors.full_messages).to include ("Password には英字と数字の両方を含めてください")
      end

      it 'パスワードは、全角英字のみでは登録できない' do
        @user.password = 'AAAAAA'
        @user.password_confirmation = 'AAAAAA'
        @user.valid?
        expect(@user.errors.full_messages).to include ("Password には英字と数字の両方を含めてください")
      end

      it 'パスワードは、英字のみでは登録できない' do
        @user.password = 'aaaAAA'
        @user.password_confirmation = 'aaaAAA'
        @user.valid?
        expect(@user.errors.full_messages).to include ("Password には英字と数字の両方を含めてください")
      end

      it 'パスワードは、数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include ("Password には英字と数字の両方を含めてください")
      end

      it 'パスワードは、全角数字を含むとでは登録できない' do
        @user.password = 'aaa１２３'
        @user.password_confirmation = 'aaa１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include ("Password には英字と数字の両方を含めてください")
      end

      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'お名前(全角)は、名字が必須であること' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include ("Family name can't be blank")
      end

      it 'お名前(全角)は、名前が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include ("First name can't be blank")
      end

      it '名字(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.family_name = 'aa11'
        @user.valid?
        expect(@user.errors.full_messages).to include ("Family name 全角文字を使用してください")
      end

      it '名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.first_name = 'aa11'
        @user.valid?
        expect(@user.errors.full_messages).to include ("First name 全角文字を使用してください")
      end

      it 'お名前カナ(全角)は、名字が必須であること' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include ("Family name kana can't be blank")
      end

      it 'お名前カナ(全角)は、名前が必須であること' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include ("First name kana can't be blank")
      end

      it '名字カナ(全角)は、英字での登録はできない。' do
        @user.family_name_kana = 'Test'
        @user.valid?
        expect(@user.errors.full_messages).to include ("Family name kana 全角カタカナを使用してください")
      end

      it '名字カナ(全角)は、数字での登録はできない。' do
        @user.family_name_kana = '1111'
        @user.valid?
        expect(@user.errors.full_messages).to include ("Family name kana 全角カタカナを使用してください")
      end

      it '名前カナ(全角)は、英字での登録はできない。' do
        @user.first_name_kana = 'Test'
        @user.valid?
        expect(@user.errors.full_messages).to include ("First name kana 全角カタカナを使用してください")
      end

      it '名前カナ(全角)は、数字での登録はできない。' do
        @user.first_name_kana = '1111'
        @user.valid?
        expect(@user.errors.full_messages).to include ("First name kana 全角カタカナを使用してください")
      end

      it '生年月日が必須であること' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include ("Birthday can't be blank")
      end
    end

  end

end
