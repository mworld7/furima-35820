require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do

    it 'email、passwordとpassword_confirmation、nickname、name、name_kana、birthday、が存在すれば登録できること' do
      expect(@user).to be_valid
    end

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
  end
end
