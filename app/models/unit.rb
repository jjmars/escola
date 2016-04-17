class Unit < ActiveRecord::Base
  belongs_to :school
  has_many :klasses
  has_many :students
  has_and_belongs_to_many :teachers
  has_and_belongs_to_many :guardians
  
  validates_presence_of :school, :title
  validates_uniqueness_of :title, scope: :school_id # não pode haver duas unidades com o mesmo nome na mesma escola
end
