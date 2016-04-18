require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  
  # Relações
  
  test 'deve pertencer a 1 escola' do
    assert_nothing_raised { Teacher.new.school }
  end
  
  test 'deve estar associado a N unidades' do
    assert_nothing_raised { Teacher.new.units }
  end
  
  test 'deve estar associado a N turmas' do
    assert_nothing_raised { Teacher.new.klasses }
  end
  
  # Válidos
  
  test 'deve salvar válido' do
    teacher = Teacher.new do |t|
      t.school  = schools(:one)
      t.klasses << klasses(:one)
      t.name    = 'Aline Alves'
      t.cpf     = '900.112.815-70'
      t.phone   = '(85) 3030-3030'
      t.email   = 'alinealves@example.com'
      t.address = 'Rua Alfa, 10, Fortaleza - CE'
    end
    assert teacher.save, 'Falhou ao salvar registro válido'
  end
  
  test 'deve salvar válido sem campos opcionais' do
    teacher = Teacher.new do |t|
      t.school  = schools(:one)
      # t.klasses << klasses(:one)
      t.name    = 'Breno Barreto'
      t.cpf     = '311.014.900-12'
      t.phone   = '(85) 4040-4040'
      t.email   = 'brenobarreto@example.com'
      t.address = 'Rua Beta, 10, Fortaleza - CE'
    end
    assert teacher.save, 'Falhou ao salvar registro válido'
  end
  
  test 'deve salvar válido com cpf repetido em outra escola' do
    teacher = Teacher.new do |t|
      t.school  = schools(:two) # outra escola
      t.name    = 'Breno Barreto'
      t.cpf     = '311.014.900-12' # mesmo professor do teste acima
      t.phone   = '(85) 4030-3030'
      t.email   = 'brenobarreto@example.com'
      t.address = 'Rua Beta, 10, Fortaleza - CE'
    end
    assert teacher.save, 'Falhou ao salvar registro válido'
  end
  
  # Inválidos
  
  test 'deve falhar ao salvar sem escola' do
    teacher = Teacher.new do |t|
      # t.school  = schools(:one)
      t.name    = 'Camila Castro'
      t.cpf     = '963.575.566-02'
      t.phone   = '(85) 5050-5050'
      t.email   = 'camilacastro@example.com'
      t.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not teacher.save, 'Salvou registro inválido'
    assert_not_nil teacher.errors[:school_id], 'Faltou indicar problema na escola'
  end
  
  test 'deve falhar ao salvar sem nome' do
    teacher = Teacher.new do |t|
      t.school  = schools(:one)
      # t.name    = 'Camila Castro'
      t.cpf     = '963.575.566-02'
      t.phone   = '(85) 5050-5050'
      t.email   = 'camilacastro@example.com'
      t.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not teacher.save, 'Salvou registro inválido'
    assert_not_nil teacher.errors[:name], 'Faltou indicar problema no nome'
  end
  
  test 'deve falhar ao salvar sem cpf' do
    teacher = Teacher.new do |t|
      t.school  = schools(:one)
      t.name    = 'Camila Castro'
      # t.cpf     = '963.575.566-02'
      t.phone   = '(85) 5050-5050'
      t.email   = 'camilacastro@example.com'
      t.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not teacher.save, 'Salvou registro inválido'
    assert_not_nil teacher.errors[:cpf], 'Faltou indicar problema no CPF'
  end
  
  test 'deve falhar ao salvar sem telefone' do
    teacher = Teacher.new do |t|
      t.school  = schools(:one)
      t.name    = 'Camila Castro'
      t.cpf     = '963.575.566-02'
      # t.phone   = '(85) 5050-5050'
      t.email   = 'camilacastro@example.com'
      t.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not teacher.save, 'Salvou registro inválido'
    assert_not_nil teacher.errors[:phone], 'Faltou indicar problema no telefone'
  end
  
  test 'deve falhar ao salvar sem email' do
    teacher = Teacher.new do |t|
      t.school  = schools(:one)
      t.name    = 'Camila Castro'
      t.cpf     = '963.575.566-02'
      t.phone   = '(85) 5050-5050'
      # t.email   = 'camilacastro@example.com'
      t.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not teacher.save, 'Salvou registro inválido'
    assert_not_nil teacher.errors[:email], 'Faltou indicar problema no email'
  end
  
  test 'deve falhar ao salvar sem endereço' do
    teacher = Teacher.new do |t|
      t.school  = schools(:one)
      t.name    = 'Camila Castro'
      t.cpf     = '963.575.566-02'
      t.phone   = '(85) 5050-5050'
      t.email   = 'camilacastro@example.com'
      # t.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not teacher.save, 'Salvou registro inválido'
    assert_not_nil teacher.errors[:address], 'Faltou indicar problema no endereço'
  end
  
  test 'deve falhar ao salvar com cpf inválido' do
    teacher = Teacher.new do |t|
      t.school  = schools(:one)
      t.name    = 'Camila Castro'
      t.cpf     = '963.575.566-01' # o último número foi digitado incorretamente (correto: '2')
      t.phone   = '(85) 5050-5050'
      t.email   = 'camilacastro@example.com'
      t.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not teacher.save, 'Salvou registro inválido'
    assert_not_nil teacher.errors[:cpf], 'Faltou indicar problema no cpf'
  end
  
  test 'deve falhar ao salvar com cpf duplicado na mesma escola' do
    teacher = Teacher.new do |t|
      t.school  = schools(:one)
      t.name    = 'Aline Alves'
      t.cpf     = teachers(:one).cpf
      t.phone   = '(85) 3030-3030'
      t.email   = 'alinealves@example.com'
      t.address = 'Rua Alfa, 10, Fortaleza - CE'
    end
    assert_not teacher.save, 'Salvou registro duplicado'
    assert_not_nil teacher.errors[:cpf], 'Faltou indicar problema no cpf'
  end
    
  test 'deve falhar ao salvar com cpf com valor de cnpj' do
    teacher = Teacher.new do |t|
      t.school  = schools(:one)
      t.name    = 'Aline Alves'
      t.cpf     = '23.722.118/0001-29' # a versão 0.2.0 da gem validates_cpf_cnpj dava falso-positivo com cnpj
      t.phone   = '(85) 3030-3030'
      t.email   = 'alinealves@example.com'
      t.address = 'Rua Alfa, 10, Fortaleza - CE'
    end
    assert_not teacher.save, 'Salvou registro duplicado'
    assert_not_nil teacher.errors[:cpf], 'Faltou indicar problema no cpf'
  end
  
end
