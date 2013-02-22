class ResumesController < ApplicationController
  respond_to :html
  responders :flash, :collection

  before_filter :show_info_for_unauthorized, only: :index
  before_filter :require_login, only: :mine
  load_and_authorize_resource except: [:index, :mine, :create], find_by: :slug

  def index
    @filter = ResumeFilter.new(params.to_hash.slice(*%w(n name s skill_list)))
    @resumes = @filter.resumes
    authorize! :read, Resume
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
    @url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
    respond_to do |format|
      format.html
      format.pdf {
        tex = TexResume.new(@resume, @url, I18n.locale)
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
