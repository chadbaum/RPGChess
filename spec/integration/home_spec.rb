require 'spec_helper'
require 'rails_helper'

describe 'home page' do
  it 'welcomes the user' do
    visit '/'
    page.should have_content('StoicChess')
  end
end



describe "security" do
  it "signs users up" do
    visit "/users/sign_up"

    fill_in "Email", :with => "user@example.com"
    fill_in("Password", with: '12345678', :match => :prefer_exact)
    fill_in("Password confirmation", with: '12345678', :match => :prefer_exact)
    click_button "Sign up"

    # page.should have_content('Welcome! You have signed up successfully.')
  end

  # it "signs out" do
  #   visit "/users/sign_out"
  #   # click_button "Sign out"
  # end

  it "signs back in" do
    visit "/users/sign_in"

    fill_in "Email", :with => "user@example.com"
    fill_in("Password", with: '12345678', :match => :prefer_exact)

    click_button "Log in"

    # page.should have_content('Signed in successfully.')
  end
end