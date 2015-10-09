class SubscribersController < ApplicationController
  def new
    @subscriber = Subscriber.new
  end

  def create
    # Create the subscriber
    subscriber = Subscriber.new(subscriber_params)
    if subscriber.save
      flash[:success] = 'Check your mail to confirm your subscription.'
      SubscriberMailer.delay.activate_user(subscriber.activation_key)
      redirect_to root_path
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
