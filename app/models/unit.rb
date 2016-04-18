class Unit < ActiveRecord::Base
  belongs_to :school
  has_many :klasses  , dependent: :destroy # usar destroy para apagar as tuplas com chaves estrangeiras
  has_many :students , dependent: :nullify
  has_many :teachers , -> { distinct }, through: :klasses
  has_many :guardians, -> { distinct }, through: :students
  
  validates_presence_of :school, :title
  validates_uniqueness_of :title, scope: :school_id # não pode haver duas unidades com o mesmo nome na mesma escola
end
