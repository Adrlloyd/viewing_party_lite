require 'rails_helper'

RSpec.describe 'new viewing party page' do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @movie1 = MovieFacade.top_rated[0]
    visit new_user_movie_viewing_party_path(@user1, @movie1.id)
  end

  it ' should display the name of the specific movie' do
    expect(page).to have_content('The Godfather')
  end

  it 'should have a field duration of party (in minutes)' do
    expect(page).to have_field(:duration)
  end

  it 'should have a field date' do
    expect(page).to have_content('Date')
  end
  
  it 'should have a field start time' do
    expect(page).to have_content('Start time')
  end

  xit 'can create a viewing party' do
    fill_in :duration, with: 175
    fill_in :date_select, with: '2-3-23'
    fill_in :time_select, with: Time.now

    page.check("attendees_#{@user2.id}")
    click_on 'Create'
    expect(current_path).to eq user_path(@user1)
  end

  xit 'cant make a viewing party with missing details' do
    fill_in :duration, with: 0
    fill_in :date, with: ''
    fill_in :start_time, with: '0'
    click_on 'Create'
    
    expect(page).to have_content 'Please fill in all details'
    expect(current_path).to eq new_user_movie_viewing_party_path(@user1, @movie1.id)
  end
end