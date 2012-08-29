require 'spec_helper'

include UsersUtilities

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.should_not change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.should change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do

    describe "as correct user" do
      before do
      	FactoryGirl.create(:micropost, user: user)
      	visit root_path
      end

      it "should delete a micropost" do
        expect { click_link "delete" }.should change(Micropost, :count).by(-1)
      end
    end

    describe "as incorrect user" do
      before do
      	FactoryGirl.create(:micropost, user: FactoryGirl.create(:user), content: "Lorem ipsum")
      	visit root_path
      end

      it "shouldn't apper the 'delete' link" do
        page.should_not have_selector('a', text: 'delete')
      end
    end
  end

  describe "pagination" do

    let(:user) { FactoryGirl.create(:user) }
    before do
      50.times { |n| FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum#{n}") }
      sign_in user
      visit user_path(user)
    end

    it "should list each micropost" do
    	should have_selector('div.pagination')
      user.microposts.paginate(page: 1).each do |micropost|
        page.should have_selector('li span.content', text: micropost.content)
      end
      user.microposts.paginate(page: 2).each do |micropost|
        page.should_not have_selector('li span.content', text: "micropost.content$")
      end
    end
  end

end
