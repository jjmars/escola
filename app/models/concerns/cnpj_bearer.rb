module CNPJBearer
  extend ActiveSupport::Concern
  
  require 'cpf_cnpj'
  
  included do
    before_validation :format_cnpj
    validates_cnpj :cnpj
  end
  
  def format_cnpj
    cnpj = CNPJ.new(cnpj).formatted
  end
end