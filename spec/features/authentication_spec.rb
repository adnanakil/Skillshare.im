require 'spec_helper'

feature "Authentication", :slow do
  scenario "signing in" do
    sign_in
    expect(signed_in?).to be

    click_link "Sign Out"
    expect(signed_out?).to be
  end

  scenario "clicking on a link that requires that a user be signed in" do
    xu = create :user, name: "Xu Li"
    visit users_path

    ed = create_user name: "Ed Lu"
    click_link "Xu Li"
    expect(current_path).to eq user_path(xu)
    expect(signed_in_as?(ed)).to be

    click_link "Sign Out"
    expect(current_path).to eq root_path
  end

  scenario "new user can customize e-mail address and location", slow: false, focus: true do
    al = create_user name: "Al"
    jo = create_user new_user: true, name: "Jo", email: "samantha@gmail.com"
    visit users_path
    click_link "Al"

    expect(current_path).to eq edit_user_path(jo)
    expect(page).to have_content("Please check")

    fill_in "E-mail", with: "cool_gurl427@hotmail.com"
    click_button "Save"

    expect(current_path).to eq new_user_proposal_path(jo)
    click_button "Create"

    expect(current_path).to eq
  end
end
