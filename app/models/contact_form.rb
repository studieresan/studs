# app/models/contact_form.rb
class ContactForm < MailForm::Base
  attribute :name,          :validate => true
  attribute :company,       :validate => true
  attribute :email,         :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,       :validate => true

  def headers
    {
      :subject => "studs 2014",
      :to => "studs-salj@d.kth.se",
      :from => %("#{name}" <#{email}>)
    }
  end
end