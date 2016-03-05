class SubscribersController < ApplicationController

  before_action :activation_key, only: %i(activate unsubscribe)

  def create
    # Create the subscriber
    subscriber = Subscriber.new(subscriber_params)
    if subscriber.save
      flash[:success] = 'Check your mail to confirm your subscription.'
      SubscriberMailer.delay.activate_subscriber(subscriber)
    else
      flash[:danger] = 'Please check the mail address before continuing.'
    end
    redirect_to root_path
  end

  def activate
    # Activate the subscriber
    subscriber = Subscriber.find_by_activation_key(activation_key)
    if subscriber && !subscriber.activated?
      subscriber.activated = true
      subscriber.save
      flash[:success] = "You will now receive all updates at #{subscriber.email}."
    else
      flash[:danger] = 'Invalid activation key'
    end
    redirect_to root_path
  end

  def unsubscribe
    # Find the subscriber by the activation key and delete it
    subscriber = Subscriber.find_by_activation_key(activation_key)
    if subscriber
      subscriber.delete
      flash[:success] = 'Unsubscribed successfully. You will no longer receive any mails from us.'
    else
      flash[:danger] = 'Invalid URL. Please try again.'
    end
    redirect_to root_path
  end

  private

  def subscriber_params
    params.permit(:email)
  end

  def activation_key
    activation_key = params[:activation_key]
  end
end
