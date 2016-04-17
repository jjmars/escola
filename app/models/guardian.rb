class Guardian < ActiveRecord::Base
  include CPFBearer
  
  belongs_to :school
  has_many :students, -> { order(:name) }
  has_and_belongs_to_many :units, -> { order(:title) } # pode ter filhos em várias unidades
  
  validates_presence_of :school, :name, :cpf, :phone, :email, :address
  validates_uniqueness_of :cpf, scope: :school_id # não pode haver dois cpf iguais na mesma escola
end
