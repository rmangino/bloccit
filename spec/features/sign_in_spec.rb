require "rails_helper"

describe "Sign in flow" do

  include TestFactories

  describe "successful" do
    
    it "redirects to the topics index" do
      user = authenticated_user
      visit root_path

      # There are multiple sign in links - pick one specifically
      within '.jumbotron' do
        click_link 'Sign In'
      end  

      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password

      within 'form' do
        click_button 'Log in'
      end

      expect( current_path ).to eq topics_path

    end

  end # describe "successful"

end # describe "Sign in flow"