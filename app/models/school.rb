class School < ActiveRecord::Base
  validates_presence_of :title, :cnpj, :phone, :email, :address
  validates_uniqueness_of :cnpj # não pode haver duas escolas com o mesmo cnpj
  validates_cnpj :cnpj
end
