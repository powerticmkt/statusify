require 'rails_helper'

RSpec.describe SubscribersController, regressor: true do
  # === Routes (REST) ===
  it { is_expected.to route(:post, '/subscribers/new').to('subscribers#create', {}) }
  it { is_expected.to route(:get, '/subscribers/activate/1').to('subscribers#activate', {:activation_key=>"1"}) }
  it { is_expected.to route(:get, '/subscribers/unsubscribe/1').to('subscribers#unsubscribe', {:activation_key=>"1"}) }
  # === Callbacks (Before) ===
  it { is_expected.to use_before_filter(:verify_authenticity_token) }
  it { is_expected.to use_before_filter(:set_xhr_redirected_to) }
  it { is_expected.to use_before_filter(:set_request_method_cookie) }
  # === Callbacks (After) ===
  it { is_expected.to use_after_filter(:abort_xdomain_redirect) }
  it { is_expected.to use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===

end
