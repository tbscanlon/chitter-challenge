feature 'Posting a Peep' do
  scenario 'Posts a peep successfully' do
    sign_up
    post_peep("Test message")
    expect(page.status_code).to be 200
  end

  scenario "Can't post a peep if not logged in" do
    post_peep("Worth a try")
    expect(page).to have_content "You must sign in or register to post a peep"
  end
end

feature 'Viewing Peeps' do
  let(:time_matcher) { /(\d{1,2}):(\d{1,2}) (\d{1,2})-(\d{1,2})-(\d{4})/ }

  before do
    sign_up
  end

  scenario 'Peep shows on the page' do
    post_peep("A test peep ha ha #sick")
    expect(page).to have_content 'A test peep ha ha #sick'
  end

  scenario 'Peeps display in reverse chronological order' do
    post_peep("First peep")
    post_peep("Second peep")
    post_peep("Third peep")
    expect("Third peep").to appear_before("Second peep")
  end

  scenario 'Peeps have a timestamp' do
    post_peep("Test message")
    expect(find("span.timestamp").text).to match time_matcher
  end

  scenario 'Peeps have an author' do
    post_peep("Test message")
    page.find("div.peep", text: "tom")
  end
end
