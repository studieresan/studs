class ResumesController < ApplicationController
  respond_to :html, :xml
  responders :flash, :collection

  before_filter :review_authorization

  load_and_authorize_resource except: [:mine, :create]

  def index
    @filter = ResumeFilter.new(params.to_hash.slice(*%w(n name s skill_list)))
    @resumes = @filter.resumes
  end

  def mine
    @resume = current_user.resume
    if @resume
      render 'show'
    else
      redirect_to action: :new
    end
  end

  def show
  end

  def new
    @resume.user = current_user

    if current_user.student?
      [:name, :email].each do |attr|
        @resume.send("#{attr}=".to_sym, current_user.send(attr))
      end
    end
  end

  def create
    @resume = Resume.new(params[:resume], as: current_user.role.to_sym)
    @resume.user = current_user unless current_user.admin?
    authorize! :create, @resume
    @resume.save
    respond_with @resume
  end

  def edit
  end

  def update
    @resume.update_attributes(params[:resume])
    @resume.save
    respond_with @resume
  end

  def delete
  end

  def destroy
  end

  private

  def review_authorization
    render 'logged_out' and return unless logged_in?
  end
end
