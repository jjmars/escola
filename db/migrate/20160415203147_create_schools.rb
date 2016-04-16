class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :title
      t.string :cnpj
      t.string :phone
      t.string :email
      t.string :address

      t.timestamps null: false
    end
  end
end
