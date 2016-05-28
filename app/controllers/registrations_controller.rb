class RegistrationsController < Devise::RegistrationsController
  protect_from_forgery except: :webhook
  # protected

  def renew
   update_attibute :end_date, Date.today + 1.day
  end
  def webhook
    event = Stripe::Event.retrieve(params["id"])

    case event.type
      when "invoice.payment_succeeded" #renew subscription
        Registration.find_by_customer_id(event.data.object.customer).renew
    end
    render status: :ok, json: "success"
  end

  def after_sign_up_path_for(resource)
    '/subscribers/new/' || '/subscribers2/new/'
  end

end