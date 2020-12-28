feature 'signing in' do
  scenario 'user can sign in' do
    visit '/'
    click_button 'Create an account'
    fill_in 'username', with: 'Panda'
    fill_in 'password', with: 'password123'
    fill_in 'name', with: 'Panda'
    fill_in 'email', with: 'panda@gmail.com'
    click_on 'Submit'
  
    fill_in 'email', with: 'panda@gmail.com'
    fill_in 'password', with: 'password123'
    click_on 'Log In'

    expect(page).to have_content 'Welcome, Panda'
  end
end