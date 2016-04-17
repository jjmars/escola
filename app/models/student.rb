class Student < ActiveRecord::Base
  belongs_to :school
  belongs_to :unit
  belongs_to :guardian
  has_and_belongs_to_many :klasses # está em várias turmas
  
  validates_presence_of :school, :unit, :guardian, :name, :enrollment
  validates_uniqueness_of :enrollment, scope: :school_id # não pode haver duas matrículas iguais na mesma escola
  
  before_save :add_unit_to_guardian, unless: Proc.new { |s| s.guardian.units.include? s.unit }
  
  def add_unit_to_guardian
    guardian.units << unit
    guardian.save
  end
end
