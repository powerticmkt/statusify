require 'rails_helper'

RSpec.describe User, regressor: true do
  # === Relations ===

  it { is_expected.to have_many :incidents }

  # === Nested Attributes ===

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }
  it { is_expected.to have_db_column :email }
  it { is_expected.to have_db_column :encrypted_password }
  it { is_expected.to have_db_column :confirmation_token }
  it { is_expected.to have_db_column :remember_token }
  it { is_expected.to have_db_column :admin }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ['email'] }
  it { is_expected.to have_db_index ['remember_token'] }

  # === Validations (Length) ===

  # === Validations (Presence) ===
  context 'with conditions' do
    before do
      allow(subject).to receive(:email_optional?).and_return(false)
    end

    it { is_expected.to validate_presence_of :email }
  end

  context 'with conditions' do
    before do
      allow(subject).to receive(:skip_password_validation?).and_return(false)
    end

    it { is_expected.to validate_presence_of :password }
  end

  # === Validations (Numericality) ===

  # === Enums ===
end
