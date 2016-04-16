require 'test_helper'

class SchoolTest < ActiveSupport::TestCase
  
  test '0100 deve salvar válido' do
    school = School.new do |s|
      s.title   = 'Escola Alfa'
      s.cnpj    = '21.236.425/0001-74'
      s.phone   = '(85) 3030-3030'
      s.email   = 'falecom@escolaalfa.com.br'
      s.address = 'Rua Alfa, 10, Fortaleza - CE'
    end
    assert school.save, 'Falhou ao salvar registro válido'
  end

  test '0200 deve falhar ao salvar sem título' do
    school = School.new do |s|
      # s.title   = 'Escola Beta'
      s.cnpj    = '23.722.118/0001-29'
      s.phone   = '(85) 4030-3030'
      s.email   = 'falecom@escolabeta.com.br'
      s.address = 'Rua Beta, 10, Fortaleza - CE'
    end
    assert_not school.save, 'Salvou registro inválido'
    assert_not_nil school.errors[:title], 'Faltou indicar problema no título'
  end

  test '0300 deve falhar ao salvar sem cnpj' do
    school = School.new do |s|
      s.title   = 'Escola Beta'
      # s.cnpj    = '23.722.118/0001-29'
      s.phone   = '(85) 4030-3030'
      s.email   = 'falecom@escolabeta.com.br'
      s.address = 'Rua Beta, 10, Fortaleza - CE'
    end
    assert_not school.save, 'Salvou registro inválido'
    assert_not_nil school.errors[:cnpj], 'Faltou indicar problema no CNPJ'
  end

  test '0400 deve falhar ao salvar sem telefone' do
    school = School.new do |s|
      s.title   = 'Escola Beta'
      s.cnpj    = '23.722.118/0001-29'
      # s.phone   = '(85) 4030-3030'
      s.email   = 'falecom@escolabeta.com.br'
      s.address = 'Rua Beta, 10, Fortaleza - CE'
    end
    assert_not school.save, 'Salvou registro inválido'
    assert_not_nil school.errors[:phone], 'Faltou indicar problema no telefone'
  end

  test '0500 deve falhar ao salvar sem email' do
    school = School.new do |s|
      s.title   = 'Escola Beta'
      s.cnpj    = '23.722.118/0001-29'
      s.phone   = '(85) 4030-3030'
      # s.email   = 'falecom@escolabeta.com.br'
      s.address = 'Rua Beta, 10, Fortaleza - CE'
    end
    assert_not school.save, 'Salvou registro inválido'
    assert_not_nil school.errors[:email], 'Faltou indicar problema no email'
  end

  test '0600 deve falhar ao salvar sem endereço' do
    school = School.new do |s|
      s.title   = 'Escola Beta'
      s.cnpj    = '23.722.118/0001-29'
      s.phone   = '(85) 4030-3030'
      s.email   = 'falecom@escolabeta.com.br'
      # s.address = 'Rua Beta, 10, Fortaleza - CE'
    end
    assert_not school.save, 'Salvou registro inválido'
    assert_not_nil school.errors[:address], 'Faltou indicar problema no endereço'
  end

  test '0700 deve falhar ao salvar com cnpj inválido' do
    school = School.new do |s|
      s.title   = 'Escola Beta'
      s.cnpj    = '23.722.118/0001-28' # o último número foi digitado incorretamente (correto: '9')
      s.phone   = '(85) 4030-3030'
      s.email   = 'falecom@escolabeta.com.br'
      s.address = 'Rua Beta, 10, Fortaleza - CE'
    end
    assert_not school.save, 'Salvou registro inválido'
    assert_not_nil school.errors[:cnpj], 'Faltou indicar problema no CNPJ'
  end

  test '0800 deve falhar ao salvar com cnpj duplicado' do
    school = School.new do |s|
      s.title   = 'Escola Alfa'
      s.cnpj    = schools(:one).cnpj # duplicado de test/fixtures/schools.yml
      s.phone   = '(85) 3030-3030'
      s.email   = 'falecom@escolaalfa.com.br'
      s.address = 'Rua Alfa, 10, Fortaleza - CE'
    end
    assert_not school.save, 'Salvou registro inválido'
    assert_not_nil school.errors[:cnpj], 'Faltou indicar problema no CNPJ'
  end
  
end
