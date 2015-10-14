class SubscribersController < ApplicationController

  def create
    # Create the subscriber
    subscriber = Subscriber.new(subscriber_params)
    if subscriber.save
      flash[:success] = 'Check your mail to confirm your subscription.'
      SubscriberMailer.delay.activate_subscriber(subscriber)
      redirect_to root_path
    else
      flash[:danger] = 'Please check the mail address before continuing.'
      redirect_to root_path
    end
  end

  def activate
    # Activate the subscriber
    activation_key = params[:activation_key]
    subscriber = Subscriber.find_by_activation_key(activation_key)
    if subscriber && !subscriber.activated?
      subscriber.activated = true
      subscriber.save
      flash[:success] = "You will now receive all updates at #{subscriber.email}."
    else !subscriber
      flash[:danger] = 'Invalid activation key'
    end
    render 'pages/index'
    #redirect_to root_path
  end

  def unsubscribe
    # Find the subscriber by the activation key and delete it
    activation_key = params[:activation_key]
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
end
