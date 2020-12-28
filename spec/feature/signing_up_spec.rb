feature 'Sign up' do
  scenario 'user can sign up' do
    visit '/'
    click_button 'Create an account'
    fill_in 'username', with: 'Panda'
    fill_in 'password', with: 'password123'
    fill_in 'name', with: 'Panda'
    fill_in 'email', with: 'panda@gmail.com'
    click_on 'Submit'
    expect(page).to have_content 'Successfully created the account. Please log in.'
  end

  scenario 'rejects if a username or email already exists' do
    User.create(email: 'test@example.com', password: 'password123', name:'Kitty', username:'HelloKitty')
    visit '/'
    click_button 'Create an account'
    fill_in 'username', with: 'HelloKitty'
    fill_in 'password', with: 'password123'
    fill_in 'name', with: 'Panda'
    fill_in 'email', with: 'random@gmail.com'
    click_on 'Submit'
    expect(page).to have_content 'The email or username is already taken.'
  end
end