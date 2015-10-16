require 'test_helper'

class IncidentsHelperTest < ActionView::TestCase
  # Even the incident helper does a lot of work. We gotta test it,
  # cuz even it might make things blow up big-time.
  include ApplicationHelper

  def user_signed_in?
    # Just a senseless stub that makes the visible incidents test work.
    false
  end

  test 'check dated_incidents' do
    @dated_incidents = dated_incidents
    @dated_incidents.each do |date, i|
      # We got to have some incidents in our fixture.
      # If this fails, everything else will fail in due time.
      assert_equal Incident::ActiveRecord_Relation, i.class, 'dated_incidents is not returning incidents'
    end
  end

  test 'check all_incidents' do
    @incidents = all_incidents
    assert_equal Incident::ActiveRecord_Relation, @incidents.class, 'all_incidents is not returning incidents.'
  end

  test 'check visible_incidents' do
    @current_user = nil
    @visible_incidents = visible_incidents
    assert_equal Incident, @visible_incidents.first.class, 'visible_incidents is not returning incidents.'
    @visible_incidents.each do |i|
      assert_equal true, i.public?
    end
  end

end