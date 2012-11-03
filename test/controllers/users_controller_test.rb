require "minitest_helper"

describe UsersController do
  context "logged in admin" do
    before do
      @user = FactoryGirl.create(:admin)
      subject.auto_login(@user)
    end

    describe "#index" do
      before { get :index }

      it { must respond_with(:success) }
      it { must assign_to(:users) }
      it { must render_template('index') }
    end
  end

  context "no logged in user" do
    describe "#index" do
      before { get :index }

      it { must respond_with(:success) }
      it { wont assign_to(:users) }
      it { must render_template('resumes/logged_out') }
    end
  end
end
