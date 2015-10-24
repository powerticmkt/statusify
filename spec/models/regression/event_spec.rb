require 'rails_helper'

RSpec.describe Event, regressor: true do

  # === Relations ===
  it { is_expected.to belong_to :incident }
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :message }
  it { is_expected.to have_db_column :status }
  it { is_expected.to have_db_column :incident_id }
  it { is_expected.to have_db_column :created_at }
  it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["incident_id"] }

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :message }
  it { is_expected.to validate_presence_of :status }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end