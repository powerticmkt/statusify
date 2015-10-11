class SubscribersController < ApplicationController

  def create
    # Create the subscriber
    subscriber = Subscriber.new(subscriber_params)
    if subscriber.save
      flash[:success] = 'Check your mail to confirm your subscription.'
      SubscriberMailer.activate_user(subscriber)
      redirect_to root_path
    else
      flash[:danger] = 'Please check the mail address before continuing.'
      redirect_to root_path
    end
  end

  private

  def subscriber_params
    params.permit(:email)
  end
end
