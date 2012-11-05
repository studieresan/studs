class ExperiencesController < ApplicationController
  respond_to :html
  responders :flash, :collection

  load_and_authorize_resource :resume
  load_and_authorize_resource :experience, through: :resume

  def new
  end

  def create
    @experience.save
    respond_with @resume, @experience, location: @resume
  end

  def edit
  end

  def update
    @experience.update_attributes(params[:experience])
    @experience.save
    respond_with @resume, @experience, location: @resume
  end

  def delete
  end

  def destroy
    @experience.destroy
    respond_with @resume, @experience, location: @resume
  end
end
