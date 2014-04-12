require 'spec_helper'

describe "Pages" do
  describe "Home page" do
    it "should have the content 'Friend'" do
      visit '/'
      expect(page).to have_content('Friend Roulette')
    end
  end
end