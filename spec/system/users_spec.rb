require 'rails_helper'

RSpec.describe "Users", type: :system do
  context 'ユーザー登録機能' do
    it '正しい値を入力した場合⇢ 登録に成功し、トップページに遷移する' do
      # 入力の為のダミーデータ生成
      @user = FactoryBot.build(:user)

      # トップページに遷移
      visit root_path

      # ユーザー登録ページへ遷移
      visit new_user_registration_path

      # 登録の為の情報を入力(正しい値)
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation

      # 登録ボタンをクリック
      find('input[name="commit"]').click

      # トップページに遷移していることを確認
      #root_pathは仮置しています😨
      expect(current_path).to eq root_path

    end
    it '不正な値を入力した場合⇢ 登録に失敗し、ユーザー登録ページに戻る' do
      # 入力の為のダミーデータ生成
      @user = FactoryBot.build(:user)

      # トップページに遷移
      visit root_path

      # ユーザー登録ページへ遷移
      visit new_user_registration_path

      # 登録の為の情報を入力(不正な値)
      fill_in 'user_nickname', with: ""
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      fill_in 'user_password_confirmation', with: ""

      # 登録ボタンをクリック
      find('input[name="commit"]').click

      # トップページに遷移していることを確認
      expect(current_path).to eq "/users"
    end
  end
  context 'ログイン機能' do
    it '正しい値を入力した場合⇢ ログインに成功し、トップページに遷移する' do

      # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)

      # トップページに遷移
      visit root_path

      # ログインページへ遷移
      visit new_user_session_path
      
      # ログインの為の情報を入力(正しい値)
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password

      # ログインボタンをクリック
      find('input[name="commit"]').click

      # トップページに遷移していることを確認する
      #root_pathは仮置しています😨
      expect(current_path).to eq root_path

    end
    it '不正な値を入力した場合⇢ ログインに失敗し、再びログインページに戻ってくる' do

      # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)

      # トップページに遷移
      visit new_user_session_path

      # ログインページへ遷移
      visit new_user_session_path

      # ログインの為の情報を入力(不正な値)
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""

      # ログインボタンをクリック
      find('input[name="commit"]').click

      # ログインページに戻ってきていることを確認する
      expect(current_path).to eq new_user_session_path

    end
  end
end