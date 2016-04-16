class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :school, index: true, foreign_key: true
      t.references :unit, index: true, foreign_key: true
      t.references :guardian, index: true, foreign_key: true
      t.string :name
      t.string :enrollment
      t.string :phone
      t.string :email
      t.string :address

      t.timestamps null: false
    end
    
    # Aluno está associado a várias turmas
    create_table :klasses_students, id: false do |t|
      t.references :klass,   index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true
    end
  end
end
