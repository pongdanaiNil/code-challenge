class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.integer :adwords_advertisers_count, null: false, default: 0
      t.integer :links_count,               null: false, default: 0
      t.integer :total_search_results,      null: false, default: 0
      t.float   :search_time,               null: false, default: 0.0
      t.text    :html_code,                 null: false, default: ''
      t.timestamps                          null: false

      t.belongs_to :keyword, index: true, foreign_key: true
    end
  end
end
