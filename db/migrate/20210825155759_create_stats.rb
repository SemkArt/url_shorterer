class CreateStats < ActiveRecord::Migration[6.1]
  def change
    create_table :stats do |t|
      t.references :url, index: true
      t.string :ip
      t.integer :views, null: false, default: 0

      t.timestamps
    end
  end
end
