class ResumesController < ApplicationController
  respond_to :html, :xml
  responders :flash, :collection

  before_filter :require_login, except: :index
  before_filter :fetch_resume, except: [:index, :new]

  def index
    render 'logged_out' and return unless logged_in?
  end

  def show
  end

  def new
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

  def fetch_resume
    @resume = Resume.find(params[:id])
  end
end
