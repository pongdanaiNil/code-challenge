class UploadKeywordsJob
  include Sidekiq::Job

  def perform(*args)
    args[0].each do |keyword|
      Keyword.create(keyword: keyword.strip) unless Keyword.where(keyword: keyword.strip).exists?
    end
  end
end
