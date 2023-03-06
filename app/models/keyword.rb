class Keyword < ApplicationRecord
  has_one :result, dependent: :destroy
  after_save :search

  default_scope { order(:keyword) }

  private

  def search
    SearchKeywordJob.perform_async(self.id, self.keyword)
  end
end
