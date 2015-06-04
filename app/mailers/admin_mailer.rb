class AdminMailer < ActionMailer::Base
  default from: "noreply@daycare.com"
  
  def forgot_password(admin)
      @admin = admin
      @url = "https://daycare-backend-stepan182.c9.io/password_reset?email=#{@admin.email}&token=#{@admin.password_digest[0..20]}"
      mail(to: @admin.email, subject: "Password reset link")
  end
end
