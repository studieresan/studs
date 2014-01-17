class ResumesController < ApplicationController
  require 'rubygems'
  require 'zip'

  respond_to :html
  responders :flash, :collection

  before_filter :show_info_for_unauthorized, only: :index
  before_filter :require_login, only: :mine
  load_and_authorize_resource except: [:index, :mine, :create], find_by: :slug

  OUTPUT_DIR = File.join(Rails.root, 'tmp', 'resumes')

  def index
    @filer_params = params.to_hash.slice(*%w(n name s skill_list))
    @filter = ResumeFilter.new(params.to_hash.slice(*%w(n name s skill_list)))
    @resumes = @filter.resumes
    authorize! :read, Resume

    respond_to do |format|
      format.html
      format.zip {
        zipfile_name = File.join(OUTPUT_DIR, "all_resumes.zip")

        File.delete(zipfile_name) if File.exists?(zipfile_name)
        Dir.mkdir(OUTPUT_DIR) unless File.directory?(OUTPUT_DIR)

        Dir.chdir OUTPUT_DIR do
          Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
            @resumes.each do |resume|
              tex = TexResume.new(resume, I18n.locale)
              path = tex.save

              if path[0].present?
                zipfile.add("#{tex.base_name}.pdf", path[0])
              end
            end
          end
        end
        send_file zipfile_name, filename: "studs.zip", type: 'application/zip'
      }
    end
  end

  def mine
    @resume = current_user.resume
    if @resume
      authorize! :read, @resume
      render 'show'
    else
      redirect_to action: :new
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf {
        tex = TexResume.new(@resume, I18n.locale)
        path = tex.save params.include?(:force)
        if path[0]
          send_file path[0], filename: "#{tex.base_name}.pdf",
          type: 'application/pdf', disposition: 'inline'
        else
          render text: path[1], status: 403, layout: false, content_type: Mime::TEXT
        end
      }
    end
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
    @resume = Resume.new(params[:resume], as: current_role)
    @resume.user = current_user unless current_user.admin?
    authorize! :create, @resume
    @resume.save
    respond_with @resume, location: @resume
  end

  def edit
  end

  def update
    @resume.update_attributes(params[:resume])
    @resume.save
    respond_with @resume, location: @resume
  end

  def delete
  end

  def destroy
    @resume.destroy
    respond_with @resume, location: resumes_path
  end

  private

  def show_info_for_unauthorized
    return if can? :index, Resume
    save_return_url
    render 'logged_out'
  end
end
