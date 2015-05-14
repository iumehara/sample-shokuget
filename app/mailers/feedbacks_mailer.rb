class FeedbacksMailer < ActionMailer::Base

  default from: "contact@shokuget.com"
  default to: "contact@shokuget.com"

  def new_feedback(feedback)
  	@feedback = feedback
  	mail(subject: "feedback:#{feedback.subject}")
  end
end
