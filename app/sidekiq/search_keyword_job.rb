class SearchKeywordJob
  include Sidekiq::Job

  def perform(*args)
    DataScraping.call(args[0], args[1])
  end
end
