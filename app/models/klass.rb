class Klass < ActiveRecord::Base
  belongs_to :school
  belongs_to :unit
  
  validates_presence_of :school, :unit, :title
  validates_uniqueness_of :title, scope: :unit_id # não pode haver duas turmas com o mesmo nome na mesma unidade
end
