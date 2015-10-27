require "rails_helper"

describe IncidentsHelper do

  def signed_in?
    false
  end

  # it "check dated_incidents" do
  #   @dated_incidents = dated_incidents
  #   @dated_incidents.each do |date, i|
  #     expect(i.class).to eq(Incident::ActiveRecord_Relation)
  #   end
  # end

  it "check all_incidents" do
    @incidents = all_incidents
    expect(@incidents.class).to eq(Incident::ActiveRecord_Relation)
  end

  # it "check visible_incidents" do
  #   @current_user = nil
  #   @visible_incidents = visible_incidents
  #   expect(@visible_incidents.first.class).to eq(Incident)
  #   @visible_incidents.each { |i| expect(i.public?).to eq(true) }
  # end
end
