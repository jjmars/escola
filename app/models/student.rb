class Student < ActiveRecord::Base
  include ActiveModel::Dirty
  
  belongs_to :school
  belongs_to :unit
  belongs_to :guardian
  has_and_belongs_to_many :klasses # está em várias turmas
  
  before_validation :remove_klasses_outside_unit
  
  validates_presence_of :school_id, :unit_id, :guardian_id, :name, :enrollment
  validates_uniqueness_of :enrollment, scope: :school_id # não pode haver duas matrículas iguais na mesma escola
  
  private
  
    def remove_klasses_outside_unit
      self.klasses = self.klasses.select { |k| k.unit_id == unit_id } if unit_id_changed?
    end
end
