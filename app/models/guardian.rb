class Guardian < ActiveRecord::Base
  belongs_to :school
  has_and_belongs_to_many :units # pode ter filhos em várias unidades
  
  validates_presence_of :school, :name, :cpf, :phone, :email, :address
  validates_uniqueness_of :cpf, scope: :school_id # não pode haver dois cpf iguais na mesma escola
  validates_cpf :cpf
end
