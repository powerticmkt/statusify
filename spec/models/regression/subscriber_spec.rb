require 'rails_helper'

RSpec.describe Subscriber, regressor: true do

  # === Relations ===

  # === Nested Attributes ===

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :email }
  it { is_expected.to have_db_column :activated }
  it { is_expected.to have_db_column :activation_key }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["activated"] }

  # === Validations (Length) ===

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :email }

  # === Validations (Numericality) ===

  # === Enums ===

end
