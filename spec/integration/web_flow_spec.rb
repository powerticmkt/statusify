# require "rails_helper"

# describe  do


#   def sign_in(email, password)
#     post_via_redirect("/session", "session[email]" => email, "session[password]" => password)
#     response
#   end

#   def create_incident(i, path)
#     return if (i.class != Incident)
#     post path, "incident[name]" => i.name, "incident[events_attributes][0][message]" => "Test Message", "incident[component]" => i.component, "incident[events_attributes][0][status]" => "Test status", "incident[severity]" => i.severity
#     response
#   end

#   def edit_incident(i, path)
#     patch(path, "incident[name]" => i[:name], "incident[event][message]" => i[:message], "incident[event][status]" => i[:status], "incident[severity]" => i[:severity])
#     response
#   end

#   def delete_incident(path)
#     delete path
#     response
#   end


#   it "get index" do
#     get "/"
#     assert_response(:success, "Failed to get index page")
#   end

#   it "sign up" do
#     get "/sign_up"
#     assert_response(:success, "Failed to get sign up page")
#     post_via_redirect("/users", "user[email]" => "a@b.com", "user[password]" => "password")
#     assert_response(:success)
#     expect(User.find_by_email("a@b.com").email).to eq("a@b.com")
#   end

#   it "sign in" do
#     get "/sign_in"
#     assert_response(:success, "Failed to get sign in page")
#     sign_in(User.first.email, "password")
#     assert_response(:success, "Failed to log in in via valid credentials.")
#     delete "/sign_out"
#     sign_in(User.first.email, "foobar")
#     assert_response(:unauthorized, "Invalid credentials work.")
#   end

#   it "create incident" do
#     sign_in(User.first.email, "password")
#     get "/incidents/new"
#     assert_response(:success, "Failed to get new incident page")
#     r = create_incident(Incident.first, "/incidents")
#     expect(r.headers["status"]).to eq("success")
#     r = create_incident(Incident.new(name: nil, component: nil), "/incidents")
#     expect(r.headers["status"]).to eq("failed")
#   end

#   it "modify incident" do
#     sign_in(User.first.email, "password")
#     get "/incidents/#{Incident.first.id}/edit"
#     assert_response(:success, "Could not get edit page")
#     i = { name: "Updated name", message: "updated message", status: "updated status", component: "Updated component", severity: "major" }
#     r = edit_incident(i, "/incidents/#{Incident.first.id}/edit")
#     expect(r.headers["status"]).to eq("success")
#     i = { name: "", message: "", status: "", component: "", severity: "" }
#     r = edit_incident(i, "/incidents/#{Incident.first.id}/edit")
#     expect(r.headers["status"]).to eq("failed")
#   end

#   it "delete incident" do
#     sign_in(User.first.email, "password")
#     r = delete_incident("/incidents/#{Incident.first.id}")
#     expect(r.headers["status"]).to eq("success")
#     r = delete_incident("/incidents/#{(rand * 10000).to_i}")
#     expect(r.headers["status"]).to eq("failed")
#   end

#   it "deactivate incident" do
#     sign_in(User.first.email, "password")
#     r = get "/incidents/#{Incident.first(2).last.id}/deactivate"
#     expect(response.headers["status"]).to eq("success")
#   end

#   it "view incident" do
#     r = get "/incidents/#{Incident.first(2).last.id}"
#     expect(flash["warning"]).to eq(nil)
#     r = get "/incidents/#{(rand * 10000).to_i}"
#     expect(flash["warning"]).to eq("Unable to find that incident")
#   end

#   it "subscribe" do
#     post create_subscriber_path, email: "valid-email@example.com"
#     expect(flash["success"]).to eq("Check your mail to confirm your subscription.")
#     post create_subscriber_path, email: "bad-mail@domain"
#     expect(flash["danger"]).to eq("Please check the mail address before continuing.")
#   end

#   it "activate" do
#     get ((Statusify.app_url + "/subscribers/activate/") + Subscriber.first.activation_key)
#     expect(flash[:success]).to eq("You will now receive all updates at #{Subscriber.first.email}.")
#     get ((Statusify.app_url + "/subscribers/activate/") + "invalid_activation_key")
#     expect(flash[:danger]).to eq("Invalid activation key")
#   end

#   it "unsubscribe" do
#     get ((Statusify.app_url + "/subscribers/unsubscribe/") + Subscriber.first.activation_key)
#     expect(flash[:success]).to eq("Unsubscribed successfully. You will no longer receive any mails from us.")
#     get ((Statusify.app_url + "/subscribers/unsubscribe/") + "invalid_activation_key")
#     expect(flash[:danger]).to eq("Invalid URL. Please try again.")
#   end

#   it "status dot check" do
#     sign_in("u@umangis.me", "password")
#     get "/status.svg"
#     assert_redirected_to("#{Statusify.app_url}/down.svg", "Redirected to unknown path, had active incidents.")
#     Incident.where(active: true).each do |m|
#       m.user = User.first
#       m.active = false
#       m.save!
#     end
#     get "/status.svg"
#     assert_redirected_to("#{Statusify.app_url}/up.svg", "Redirected to unknown path, had inactive incidents only.")
#   end

# end
