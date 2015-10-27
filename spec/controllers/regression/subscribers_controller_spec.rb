require 'rails_helper'

RSpec.describe SubscribersController, regressor: true do
  # === Routes (REST) ===
  it { should route(:post, '/subscribers/new').to('subscribers#create', {}) } 
  it { should route(:get, '/subscribers/activate/1').to('subscribers#activate', {:activation_key=>"1"}) }
  it { should route(:get, '/subscribers/unsubscribe/1').to('subscribers#unsubscribe', {:activation_key=>"1"}) }
  # === Callbacks (Before) ===
  it { should use_before_filter(:verify_authenticity_token) }
  it { should use_before_filter(:set_xhr_redirected_to) }
  it { should use_before_filter(:set_request_method_cookie) }
  # === Callbacks (After) ===
  it { should use_after_filter(:abort_xdomain_redirect) }
  it { should use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===
  
end