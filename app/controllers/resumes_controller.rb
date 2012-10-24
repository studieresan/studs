class ResumesController < ApplicationController
  respond_to :html, :xml
  responders :flash, :collection

  before_filter :review_authorization
  before_filter :fetch_resume, except: [:index, :new]

  def index
    @resumes = Resume.all
  end

  def show
  end

  def new
    @resume = Resume.new
    if current_user.student?
      [:name, :email].each do |attr|
        @resume.send("#{attr}=".to_sym, current_user.send(attr))
      end
    end
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private

  def review_authorization
    render 'logged_out' and return unless logged_in?
  end

  def fetch_resume
    @resume = Resume.find(params[:id])
  end
end
