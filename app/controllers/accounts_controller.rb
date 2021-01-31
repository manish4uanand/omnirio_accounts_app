require 'httparty'

class AccountsController < ApplicationController

  def create
    # user creation code in customer app
    customer_app_url = 'http://localhost:3001/v1/users'
    options = { body: {
      user: {
        user_name: params[:customer_name],
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation],
        gender: params[:gender],
        date_of_birth: params[:date_of_birth],
        phone_number: params[:phone_number]
      }
      } 
    }
    response = HTTParty.post(customer_app_url, options)
    return unless response.message == 'OK'

    account = Account.new(account_params)
    account.open_date = Date.today
    account.customer_id = response['id']
    if account.save
      render json: account, status: :ok
    else
      head(:unprocessible_entity)
    end 
  end

  private

  def account_params
    params.require(:account).permit(:account_type, :customer_name, :branch, :minor_indicator, :email, :password, :password_confirmation, :gender, :date_of_birth, :phone_number)
  end

end
