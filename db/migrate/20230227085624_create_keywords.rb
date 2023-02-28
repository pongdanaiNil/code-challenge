class CreateKeywords < ActiveRecord::Migration[7.0]
  def change
    create_table :keywords do |t|
      t.text :keyword,                      null: false, default: ''
      t.timestamps                          null: false

      t.index ['keyword'],   name: 'index_keyword_on_keyword'
    end
  end
end
