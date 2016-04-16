class Unit < ActiveRecord::Base
  belongs_to :school
  
  validates_presence_of :school, :title
  validates_uniqueness_of :title, scope: :school_id # não pode haver duas unidades com o mesmo nome na mesma escola
end
