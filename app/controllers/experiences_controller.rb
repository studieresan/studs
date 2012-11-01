class ExperiencesController < ApplicationController
  respond_to :html, :xml
  responders :flash, :collection

  before_filter :require_login

  load_and_authorize_resource :resume
  load_and_authorize_resource :experience, through: :resume

  def new
  end

  def create
  end

  def edit
  end

  def update
  end
end
