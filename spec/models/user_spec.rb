require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    # validation examples here
    it "should successfully create a new user" do
      @user = User.create(name: 'test', email: 'test', password: 'test', password_confirmation: 'test')
      expect(@user).to be_valid
    end

    it "is not valid without a password" do
      @user = User.create(name: 'test', email: 'test', password: nil, password_confirmation: 'nottest')
      expect(@user).not_to be_valid
    end

    it "is not valid without matching passwords" do
      @user = User.create(name: 'test', email: 'test', password: 'test', password_confirmation: 'nottest')
      expect(@user).not_to be_valid
    end

    it "is not valid without a name" do
      @user = User.create(name: nil, email: 'test', password: 'test', password_confirmation: 'nottest')
      expect(@user).not_to be_valid
    end

    it "is not valid without an email" do
      @user = User.create(name: 'test', email: nil, password: 'test', password_confirmation: 'nottest')
      expect(@user).not_to be_valid
    end

    it "is not valid when email already exists" do
      @user = User.create(name: 'test', email: 'TEST@test.com', password: 'test', password_confirmation: 'test')
      @user2 = User.create(name: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test')
      expect(@user2).not_to be_valid
    end

    it "is not valid without a password over 3 characters" do
      @user = User.create(name: 'test', email: 'test', password: 'tes', password_confirmation: 'tes')
      expect(@user).not_to be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    describe '.authenticate_with_credentials' do
      it "should log in if credentials match" do
        @user = User.create(name: 'test', email: 'test', password:'test', password_confirmation:'test')
        loggingInUser = User.authenticate_with_credentials('test', 'test')
        expect(loggingInUser).to eq(@user)
      end

      it "should not log in if credentials don't match" do
        @user = User.create(name: 'test', email: 'test', password:'test', password_confirmation:'test')
        loggingInUser = User.authenticate_with_credentials('test', 'testing')
        expect(loggingInUser).to eq(nil)
      end

      it "should ignore whitespace" do
        @user = User.create(name: 'test', email: 'test', password:'test', password_confirmation:'test')
        loggingInUser = User.authenticate_with_credentials('    test   ', 'test')
        expect(loggingInUser).to eq(@user)
      end

      it "should ignore capitals" do
        @user = User.create(name: 'test', email: 'test', password:'test', password_confirmation:'test')
        loggingInUser = User.authenticate_with_credentials('TEST', 'test')
        expect(loggingInUser).to eq(@user)
      end
    end
  end
end
