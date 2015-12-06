require 'rails_helper'

RSpec.describe IncidentsController, regressor: true do
  # === Routes (REST) ===
  it { is_expected.to route(:get, '/incidents/new').to('incidents#new', {}) }
  it { is_expected.to route(:post, '/incidents').to('incidents#create', {}) }
  it { is_expected.to route(:get, '/incidents/1/edit').to('incidents#edit', id: '1') }
  it { is_expected.to route(:patch, '/incidents/1/edit').to('incidents#update', id: '1') }
  it { is_expected.to route(:get, '/incidents/1/delete').to('incidents#delete', id: '1') }
  it { is_expected.to route(:get, '/incidents/1/deactivate').to('incidents#deactivate', id: '1') }
  it { is_expected.to route(:get, '/incidents/1').to('incidents#view', id: '1') }
  # === Callbacks (Before) ===
  it { is_expected.to use_before_filter(:verify_authenticity_token) }
  it { is_expected.to use_before_filter(:set_xhr_redirected_to) }
  it { is_expected.to use_before_filter(:set_request_method_cookie) }
  it { is_expected.to use_before_filter(:require_login) }
  # === Callbacks (After) ===
  it { is_expected.to use_after_filter(:abort_xdomain_redirect) }
  it { is_expected.to use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===
end
