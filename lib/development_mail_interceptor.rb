class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.subject}"
  end
end