module CPFBearer
  extend ActiveSupport::Concern
  
  require 'cpf_cnpj'
  
  included do
    before_validation :format_cpf
    validates_cpf :cpf
  end
  
  def format_cpf
    cpf = CPF.new(cpf).formatted
  end
end