class UserMailer < ActionMailer::Base
  default from: "StuDs ledning <studs-ledning@d.kth.se>"

  def credentials_mail(user, password)
    raise "Can't send credentials mail for an unsaved user!" if user.new_record?

    @hash = Hash[%w(login name email).map(&:to_sym).map { |a| [a, user.send(a)] }]
    @hash[:password] = password

    mail to: user.email, subject: I18n.t('users.credentials_mail.subject', @hash) do |format|
      format.text do
        render text: I18n.t('users.credentials_mail.body', @hash)
      end
    end
  end
end
