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

    describe "#show" do
      before { get :show, id: @user.id }

      it { must respond_with(:success) }
      it { must assign_to(:user).with(@user) }
      it { must render_template('show') }
    end

    describe "#new" do
      before { get :new }

      it { must respond_with(:success) }
      it { must assign_to(:user) }
      it { must render_template('new') }
    end

    describe "#edit" do
      before { get :edit, id: @user.id }

      it { must respond_with(:success) }
      it { must assign_to(:user).with(@user) }
      it { must render_template('edit') }
    end
  end

  context "no logged in user" do
    describe "#index" do
      before { get :index }
      it { must respond_with(:redirect) }
      it { must assign_to(:users).with([]) }
    end
  end
end
