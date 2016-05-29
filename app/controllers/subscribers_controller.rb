class SubscribersController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    
  end

  def renew
   update_attibute :end_date, Date.today + 1.day
  end

  def update
    token = params[:stripeToken] 
    customer = Stripe::Customer.create(
        card: token,
        plan: 999,
        email: current_user.email
        )

    current_user.subscribed = true
   
    current_user.stripeid = customer.id
    current_user.save
    cusotmer_id = customer.id
    
    redirect_to user_path(current_user)

  end
end
