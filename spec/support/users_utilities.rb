include ApplicationHelper

module UsersUtilities

	def valid_signin(user)
		fill_in "Email",    with: user.email
		fill_in "Password", with: user.password
		click_button "Sign in"
	end

	def default_valid_user
		fill_in "Name",         with: "Example User"
		fill_in "Email",        with: "user@example.com"
		fill_in "Password",     with: "foobar"
		fill_in "Confirmation", with: "foobar"
	end

end
