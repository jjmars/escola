class CreateGuardians < ActiveRecord::Migration
  def change
    create_table :guardians do |t|
      t.references :school, index: true, foreign_key: true
      t.string :name
      t.string :cpf
      t.string :phone
      t.string :email
      t.string :address

      t.timestamps null: false
    end
    
    # Responsável está associado a várias unidades (ex.: filhos nas unidades A e B da escola)
    create_table :guardians_units, id: false do |t|
      t.references :guardian, index: true, foreign_key: true
      t.references :unit,     index: true, foreign_key: true
    end
  end
end
