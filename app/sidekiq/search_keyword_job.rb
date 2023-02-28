class SearchKeywordJob
  include Sidekiq::Job
  include HTTParty

  def perform(*args)

    data = {
      adwords_advertisers_count: 0,
      links_count: 0,
      total_search_results: '',
      html_code: ''
    }

    headers = {
      "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.5481.178 Safari/537.36"
    }

    params = {
      q: args[1],
      hl: "en"
    }

    response = HTTParty.get('https://www.google.com/search',
                        query: params,
                        headers: headers)

    data[:html_code] = response.body             
    doc = Nokogiri::HTML(response.body)

    attrs = doc.xpath('//a/@href')
    links = attrs.map {|attr| attr.value}
    data[:links_count] = links.count

    total_results_and_search_time_node  = doc.css("div#result-stats").children.text
    data[:total_search_results] = total_results_and_search_time_node

    ads = doc.css("div#tads").children.count
    data[:adwords_advertisers_count] = ads

    Result.upsert( { **data, keyword_id: args[0] } )

  end
end
