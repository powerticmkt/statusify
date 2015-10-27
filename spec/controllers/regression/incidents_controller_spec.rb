require 'rails_helper'

RSpec.describe IncidentsController, regressor: true do
  # === Routes (REST) ===
  it { should route(:get, '/incidents/new').to('incidents#new', {}) }
  it { should route(:post, '/incidents').to('incidents#create', {}) } 
  it { should route(:get, '/incidents/1/edit').to('incidents#edit', {:id=>"1"}) }
  it { should route(:patch, '/incidents/1/edit').to('incidents#update', {:id=>"1"}) } 
  it { should route(:get, '/incidents/1/delete').to('incidents#delete', {:id=>"1"}) }
  it { should route(:get, '/incidents/1/deactivate').to('incidents#deactivate', {:id=>"1"}) }
  it { should route(:get, '/incidents/1').to('incidents#view', {:id=>"1"}) }
  # === Callbacks (Before) ===
  it { should use_before_filter(:verify_authenticity_token) }
  it { should use_before_filter(:set_xhr_redirected_to) }
  it { should use_before_filter(:set_request_method_cookie) }
  it { should use_before_filter(:require_login) }
  # === Callbacks (After) ===
  it { should use_after_filter(:abort_xdomain_redirect) }
  it { should use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===
  
end