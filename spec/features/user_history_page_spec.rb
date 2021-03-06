require 'rails_helper'

describe 'Users history page' do
  let!(:user) { FactoryGirl.create :user }
  let!(:post) { FactoryGirl.create :post_with_category }

  it 'should show expired post' do
    login_as(user)
    post.update_attribute(:ending_date, 2.days.ago)

    visit user_history_path

    expect(page).to have_content 'Koiran ulkoilutus'
  end

  it 'should show post with two ratings' do
    login_as(user)
    FactoryGirl.create :rating2
    FactoryGirl.create :rating3

    visit user_history_path

    expect(page).to have_content 'Koiran ulkoilutus'
  end

  it 'should not show post with one rating' do
    login_as(user)
    FactoryGirl.create :rating2

    visit user_history_path

    expect(page).not_to have_content 'Koiran ulkoilutus'
  end
end