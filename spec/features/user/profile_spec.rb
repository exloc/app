require "rails_helper"

describe "user profile" do
  let(:user) { create(:user) }

  xit "shows a user their personal information" do
    sign_in(user)
    visit users_path(user)
    expect(page).to have_content(user.provider)
    expect(page).to have_content(user.uid)
    expect(page).to have_content(user.token)
  end
end
