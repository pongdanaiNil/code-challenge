class Api::V1::KeywordsController < ApplicationController
  before_action :find_by_id,          only: %i[show update destroy]
  before_action :keyword_params,      only: %i[update]

  def index
    keyword = Keyword.select(*columns).limit(limit).offset(offset).as_json

    render_ok(count: count(keyword), data: keyword)
  end

  def show
    render_ok(
      data: @keyword,
      result: @keyword.result
    )
  end

  def update
    if @keyword.update(@keyword_params)
      render_ok(data: @keyword, message: I18n.t('keyword.success.updated'))
    else
      render_bad_request(message: @keyword.errors.full_messages.uniq.join(', '))
    end
  end

  def destroy
    if @keyword.destroy
      render_ok(message: I18n.t('keyword.success.destroyed'))
    else
      render_bad_request(message: @keyword.errors.full_messages.uniq.join(', '))
    end
  end

  def upload_csv
    pp "csv_params", csv_params
  end

  private

  def keyword_params
    @keyword_params = strip_params(params.permit([:keyword]))
  end

  def csv_params
    params.permit([:csv_file])
  end

  def find_by_id
    @keyword = Keyword.find_by(id: params[:id])
    render_not_found unless @keyword
  end

  def columns
    ['id, keyword, count(*) over () as count']
  end
end
