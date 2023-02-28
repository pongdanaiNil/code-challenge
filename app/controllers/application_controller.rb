class ApplicationController < ActionController::API
  wrap_parameters format: :json
  before_action :doorkeeper_authorize!

  def strip_params(values)
    values.each_value { |value| value.strip! if value.instance_of?(String) }
  end

  def page
    (params[:page] || 1).to_i
  end

  def limit
    (params[:limit] || 10).to_i
  end

  def offset
    (page - 1) * limit
  end

  def count(records)
    (records.dig(0, :count) || records.dig(0, 'count')).to_i
  end

  def current_user
    @current_user ||= User.find_by(id: doorkeeper_token.resource_owner_id) if doorkeeper_token.present?
  end

  def render_ok(data = { message: I18n.t('ok') })
    render status: :ok, json: data
  end

  def render_created(data = { message: I18n.t('created') })
    render status: :created, json: data
  end

  def render_bad_request(data = { message: I18n.t('bad_request') })
    render status: :bad_request, json: data
  end

  def render_forbidden(data = { message: I18n.t('forbidden') })
    render status: :forbidden, json: data
  end

  def render_not_found(data = { message: I18n.t('not_found') })
    render status: :not_found, json: data
  end

end
