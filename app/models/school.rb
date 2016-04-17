class School < ActiveRecord::Base
  include CNPJBearer
  
  has_many :units,     -> { order(:title) }
  has_many :klasses,   -> { order(:title) }
  has_many :teachers,  -> { order(:name) }
  has_many :students,  -> { order(:name) }
  has_many :guardians, -> { order(:name) }
  
  validates_presence_of :title, :cnpj, :phone, :email, :address
  validates_uniqueness_of :cnpj # não pode haver duas escolas com o mesmo cnpj
end
