class ContactFormController < ApplicationController
  def create
  	begin
        contact_form = ContactForm.new(params[:contact_form])
        contact_form.request = request
        f contact_form.deliver
          flash.now[:notice] = t '.thanks'
        else
          flash.now[:error] = t '.error'
        end
      rescue ScriptError
        flash[:error] = 'Sorry, this message appears to be spam and was not delivered.'
      end
  end
end
