class Klass < ActiveRecord::Base
  belongs_to :school
  belongs_to :unit
  has_and_belongs_to_many :teachers
  has_and_belongs_to_many :students
  
  validates_presence_of :school, :unit, :title
  validates_uniqueness_of :title, scope: :unit_id # não pode haver duas turmas com o mesmo nome na mesma unidade
end
