require 'rails_helper'

RSpec.describe 'Feature tests', type: :feature do
  context 'An unauthorized user' do
    it 'has a link to a topic page' do
      create(:topic)
      visit '/'
      click_on 'Hello world'
      expect(page).to have_content('Hi everyone!')
    end

    it 'cannot add comments' do
      create(:topic)
      visit '/'
      click_on 'Hello world'
      click_on 'Comment'
      fill_in 'text', with: 'despacito'
      click_on 'Submit'
      expect(page).not_to have_text('despacito')
    end
  end

  context 'An authorized user' do
    it 'can add comment' do
      create(:topic)
      sign_in create(:user)
      visit '/'
      click_on 'Hello world'
      click_on 'Comment'
      fill_in 'text', with: 'despacito'
      click_on 'Submit'
      expect(page).to have_text('despacito')
    end

    it 'can delete own comment' do
      create(:topic)
      sign_in create(:tony_hawk)
      visit '/'
      click_on 'Hello world'
      click_on 'Comment'
      fill_in 'text', with: 'despacito'
      click_on 'Submit'
      click_on 'x'
      expect(page).not_to have_text('despacito')
    end
  end

  context 'The ADMIN' do
    it 'can delete any comment' do
      sign_in create(:admin)
      create(:comment_from_tony_hawk)
      visit '/'
      click_on 'Hello world'
      click_on 'x'
      expect(page).not_to have_text('tony hawk')
    end
  end
end
