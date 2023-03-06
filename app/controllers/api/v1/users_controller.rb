class Api::V1::UsersController < ApplicationController
  wrap_parameters false
  skip_before_action :doorkeeper_authorize!,        only: :registration
  before_action :on_create_params,                  only: :registration
  
  def me
    return render_not_found if current_user.blank?

    render_ok(user: current_user)
  end

  def registration
    user = User.new(@user_params)
    return render_bad_request(message: user.errors.full_messages.uniq.join(', ')) unless user.save

    render_created(user:, message: I18n.t('user.success.created'))
  end

  private

  def on_create_params
    user_params(%i[name email password password_confirmation])
  end

  def user_params(permit_keys = [])
    @user_params = strip_params(
      params.permit(permit_keys)
    )
  end
end
