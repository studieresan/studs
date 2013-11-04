class ContactFormController < ApplicationController
  def create
  	begin
        contact_form = ContactForm.new(params[:contact_form])
        contact_form.request = request
        if contact_form.deliver
          flash.now[:notice] = t 'contact_form.create.thanks'
        else
          flash.now[:error] = t 'contact_form.create.error'
        end
        render 'create'
    rescue ScriptError
        flash[:error] = t 'contact_form.create.error'
        render 'create'
      end
  end
end
