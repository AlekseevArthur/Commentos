class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :text
      t.belongs_to :topic, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
