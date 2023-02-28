class UploadKeywordsJob
  include Sidekiq::Job

  def perform(*args)
    # process only 100 keywords
    args[0][0..99].each do |keyword|
      Keyword.create(keyword: keyword) unless Keyword.where(keyword: keyword).exists?
    end
  end
end
