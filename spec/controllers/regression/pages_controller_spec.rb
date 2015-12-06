require 'rails_helper'

RSpec.describe PagesController, regressor: true do
  # === Routes (REST) ===
  it { is_expected.to route(:get, '/').to('pages#index', {}) }
  it { is_expected.to route(:get, '/history').to('pages#history', {}) }
  it { is_expected.to route(:get, '/status.svg').to('pages#current_status_dot', {}) }
  # === Callbacks (Before) ===
  it { is_expected.to use_before_filter(:verify_authenticity_token) }
  it { is_expected.to use_before_filter(:set_xhr_redirected_to) }
  it { is_expected.to use_before_filter(:set_request_method_cookie) }
  # === Callbacks (After) ===
  it { is_expected.to use_after_filter(:abort_xdomain_redirect) }
  it { is_expected.to use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===
  
end