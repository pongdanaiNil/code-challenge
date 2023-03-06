class DataScraping < ApplicationService
  include HTTParty
  attr_reader :keyword_id, :keyword

  def initialize(keyword_id, keyword)
    @keyword_id = keyword_id
    @keyword = keyword
  end

  def call
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
      q: @keyword,
      hl: "en"
    }

    response = HTTParty.get('https://www.google.com/search',
                        query: params,
                        headers: headers)

    html_code = response.body.dup
    doc = Nokogiri::HTML(response.body)

    attrs = doc.xpath('//a/@href')
    links = attrs.map {|attr| attr.value}
    data[:links_count] = links.count

    replace_url(html_code)
    data[:html_code] = html_code 

    total_search_results = doc.css("div#result-stats").children.text
    data[:total_search_results] = total_search_results

    ads = doc.css("div#tads").children.count
    data[:adwords_advertisers_count] = ads

    Result.upsert( { **data, keyword_id: @keyword_id } )
  end

  private

  def replace_url(html_code)
    html_code.gsub!('href="/search?', 'href="https://www.google.com/search?')
    html_code.gsub!('content="/', 'content="https://www.google.com/')
    html_code.gsub!('src="/images', 'src="https://www.google.com/images')
  end

end
