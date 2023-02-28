class Keyword < ApplicationRecord
  has_one :result, dependent: :destroy

  default_scope { order(:keyword) }
end
