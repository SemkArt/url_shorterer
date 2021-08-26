class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.string :original
      t.string :short

      t.timestamps
    end

    add_index :urls, :short, unique: true
  end
end
