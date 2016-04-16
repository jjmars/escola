class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.references :school, index: true, foreign_key: true
      t.string :title
      t.string :phone
      t.string :email
      t.string :address

      t.timestamps null: false
    end
  end
end
