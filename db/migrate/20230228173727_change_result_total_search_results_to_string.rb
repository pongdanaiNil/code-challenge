class ChangeResultTotalSearchResultsToString < ActiveRecord::Migration[7.0]
  def change
    change_column :results, :total_search_results, :string
    remove_column :results, :search_time
  end
end
