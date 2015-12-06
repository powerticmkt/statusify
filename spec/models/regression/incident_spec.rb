require 'rails_helper'

RSpec.describe Incident, regressor: true do
  # === Relations ===
  it { is_expected.to belong_to :user }

  it { is_expected.to have_many :events }

  # === Nested Attributes ===
  it { is_expected.to accept_nested_attributes_for :events }

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :name }
  it { is_expected.to have_db_column :component }
  it { is_expected.to have_db_column :status }
  it { is_expected.to have_db_column :public }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }
  it { is_expected.to have_db_column :active }
  it { is_expected.to have_db_column :user_id }
  it { is_expected.to have_db_column :severity }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ['active'] }
  it { is_expected.to have_db_index ['created_at'] }
  it { is_expected.to have_db_index ['id'] }
  it { is_expected.to have_db_index ['user_id'] }

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(256)).for :name }
  it { is_expected.not_to allow_value(Faker::Lorem.characters(257)).for :name }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :component }
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :severity }

  # === Validations (Numericality) ===

  # === Enums ===
end
