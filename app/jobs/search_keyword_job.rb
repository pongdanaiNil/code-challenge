class SearchKeywordJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    pp "----------------------Search Job-------------------"
  end
end
