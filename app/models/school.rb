class School < ActiveRecord::Base
  include CNPJBearer

  has_many :users
  has_many :units
  has_many :klasses
  has_many :teachers
  has_many :students
  has_many :guardians
  
  validates_presence_of :title, :cnpj, :phone, :email, :address
  validates_uniqueness_of :cnpj # não pode haver duas escolas com o mesmo cnpj
end
