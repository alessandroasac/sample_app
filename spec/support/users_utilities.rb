include ApplicationHelper

module UsersUtilities

	def sign_in(user)
		visit signin_path
		fill_in "Email",    with: user.email
		fill_in "Password", with: user.password
		click_button "Sign in"

		# Sign in when not using Capybara as well.
		cookies[:remember_token] = user.remember_token
	end

	def default_valid_user
		fill_in "Name",         with: "Example User"
		fill_in "Email",        with: "user@example.com"
		fill_in "Password",     with: "foobar"
		fill_in "Confirm Password", with: "foobar"
	end

end
