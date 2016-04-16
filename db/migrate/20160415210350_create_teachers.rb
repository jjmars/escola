class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.references :school, index: true, foreign_key: true
      t.string :name
      t.string :cpf
      t.string :phone
      t.string :email
      t.string :address

      t.timestamps null: false
    end
    
    # Professor está associado a várias unidades
    create_table :teachers_units, id: false do |t|
      t.references :teacher, index: true, foreign_key: true
      t.references :unit,    index: true, foreign_key: true
    end
    
    # Professor está associado a várias turmas
    create_table :klasses_teachers, id: false do |t|
      t.references :klass,   index: true, foreign_key: true
      t.references :teacher, index: true, foreign_key: true
    end
  end
end
