class UserMailer < ActionMailer::Base
  default from: "studs-ledning@d.kth.se"

  def credentials_mail(user)
    raise "Can't send credentials mail for an unsaved user!" if user.new_record?
    @user = user
    @hash = Hash[%w(login password name email).map(&:to_sym).map { |a| [a, user.send(a)] }]
    mail to: user.email, subject: I18n.t('users.credentials_mail.subject', @hash) do |format|
      format.text do
        render text: I18n.t('users.credentials_mail.body', @hash)
      end
    end
  end
end
