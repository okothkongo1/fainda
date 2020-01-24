require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'admin table columns' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :created_at }
    it { is_expected.to have_db_column :updated_at }
    it { is_expected.to have_db_column :encrypted_password }
    it { is_expected.to have_db_column :reset_password_token }
    it { is_expected.to have_db_column :reset_password_sent_at }
    it { is_expected.to have_db_column :remember_created_at }
  end
  describe 'admin attributes validation' do
    it { is_expected.to validate_presence_of(:password) }  
    it { is_expected.to validate_presence_of(:email) }
    context 'should not be invalid email address' do
      emails = ['ppp@ qr.com', '@example.com', 'trial test @gmail.com',
                'linda@podii', 'yyy@.x. .x', 'zzz@.z']
      emails.each do |email|
        it { is_expected.not_to allow_value(email).for(:email) }
      end
    end
    context 'should allow valid email address' do
      emails = ['flower@fl.com', 'helloworld@example.ke', 'trialbait@goosepump.de',
                'okothkkk@gmail.com', 'janedoe@originals.ze']
      emails.each do |email|
        it { is_expected.to allow_value(email).for(:email) }
      end
    end
    context 'should not be invalid passwords' do
      passwords = ['Pass@12', 'CAPITAL LONGER', 'smallstrongerandbetter',
                   '***@###22', 'smallandsymbols#$%', 'mixtureNOSymbols1234']
      passwords.each do |password|
        it { is_expected.not_to allow_value(password).for(:password) }
      end
    end
    context 'should  be invalid passwords' do
      passwords = ['Password@12', 'CAPITAL LONGERsmall123.', 'smallstronger(andbe0tterCAP',
                   '***@###22jackBuer', 'mixtureNO#Symbols1234']
      passwords.each do |password|
        it { is_expected.to allow_value(password).for(:password) }
      end
    end  
  end
  describe '#create admi' do
    it 'should create admin with valid attributes' do
      admin = FactoryBot.create(:admin)
      expect(admin).to be_valid
    end
    it 'it should not allow admin with same email to be created' do
      FactoryBot.create(:admin)
      admin = FactoryBot.build(:admin, email: 'admin@random.com')
      admin.save
      expect(admin).not_to be_valid
      expect(admin.errors.messages[:email]).to eq ['has already been taken']
    end
    it 'should not create admin with weak password' do
      admin = FactoryBot.build(:admin, password: '1238', password_confirmation: '1238')
      admin.save
      expect(admin).not_to be_valid
      expect(admin.errors.messages[:password]).to eq ['Complexity requirement not met. Length should be at least 8 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character']
    end   
  end
end    
