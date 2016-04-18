require 'test_helper'

class GuardianTest < ActiveSupport::TestCase
  
  # Relações
  
  test 'deve pertencer a 1 escola' do
    assert_nothing_raised { Guardian.new.school }
  end
  
  test 'deve possuir N alunos' do
    assert_nothing_raised { Guardian.new.students }
  end
  
  # Válidos
  
  test 'deve salvar válido' do
    guardian = Guardian.new do |g|
      g.school  = schools(:one)
      g.name    = 'Aline Alves'
      g.cpf     = '900.112.815-70'
      g.phone   = '(85) 3030-3030'
      g.email   = 'alinealves@example.com'
      g.address = 'Rua Alfa, 10, Fortaleza - CE'
    end
    assert guardian.save, 'Falhou ao salvar registro válido'
  end
  
  test 'deve salvar válido com cpf usado em outra escola' do
    guardian = Guardian.new do |g|
      g.school  = schools(:two) # outra escola
      g.name    = 'Qualquer Nome'
      g.cpf     = guardians(:one).cpf # cpf usado na escola :one
      g.phone   = '(85) 4030-3030'
      g.email   = 'qualquernome@example.com'
      g.address = 'Rua Beta, 10, Fortaleza - CE'
    end
    assert guardian.save, 'Falhou ao salvar registro válido'
  end
  
  # Inválidos
  
  test 'deve falhar ao salvar sem escola' do
    guardian = Guardian.new do |g|
      # g.school  = schools(:one)
      g.name    = 'Camila Castro'
      g.cpf     = '963.575.566-02'
      g.phone   = '(85) 5050-5050'
      g.email   = 'camilacastro@example.com'
      g.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not guardian.save, 'Salvou registro inválido'
    assert_not_nil guardian.errors[:school_id], 'Faltou indicar problema na escola'
  end
  
  test 'deve falhar ao salvar sem nome' do
    guardian = Guardian.new do |g|
      g.school  = schools(:one)
      # g.name    = 'Camila Castro'
      g.cpf     = '963.575.566-02'
      g.phone   = '(85) 5050-5050'
      g.email   = 'camilacastro@example.com'
      g.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not guardian.save, 'Salvou registro inválido'
    assert_not_nil guardian.errors[:name], 'Faltou indicar problema no nome'
  end
  
  test 'deve falhar ao salvar sem cpf' do
    guardian = Guardian.new do |g|
      g.school  = schools(:one)
      g.name    = 'Camila Castro'
      # g.cpf     = '963.575.566-02'
      g.phone   = '(85) 5050-5050'
      g.email   = 'camilacastro@example.com'
      g.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not guardian.save, 'Salvou registro inválido'
    assert_not_nil guardian.errors[:cpf], 'Faltou indicar problema no CPF'
  end
  
  test 'deve falhar ao salvar sem telefone' do
    guardian = Guardian.new do |g|
      g.school  = schools(:one)
      g.name    = 'Camila Castro'
      g.cpf     = '963.575.566-02'
      # g.phone   = '(85) 5050-5050'
      g.email   = 'camilacastro@example.com'
      g.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not guardian.save, 'Salvou registro inválido'
    assert_not_nil guardian.errors[:phone], 'Faltou indicar problema no telefone'
  end
  
  test 'deve falhar ao salvar sem email' do
    guardian = Guardian.new do |g|
      g.school  = schools(:one)
      g.name    = 'Camila Castro'
      g.cpf     = '963.575.566-02'
      g.phone   = '(85) 5050-5050'
      # g.email   = 'camilacastro@example.com'
      g.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not guardian.save, 'Salvou registro inválido'
    assert_not_nil guardian.errors[:email], 'Faltou indicar problema no email'
  end
  
  test 'deve falhar ao salvar sem endereço' do
    guardian = Guardian.new do |g|
      g.school  = schools(:one)
      g.name    = 'Camila Castro'
      g.cpf     = '963.575.566-02'
      g.phone   = '(85) 5050-5050'
      g.email   = 'camilacastro@example.com'
      # g.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not guardian.save, 'Salvou registro inválido'
    assert_not_nil guardian.errors[:address], 'Faltou indicar problema no endereço'
  end
  
  test 'deve falhar ao salvar com cpf inválido' do
    guardian = Guardian.new do |g|
      g.school  = schools(:one)
      g.name    = 'Camila Castro'
      g.cpf     = '963.575.566-01' # o último número foi digitado incorretamente (correto: '2')
      g.phone   = '(85) 5050-5050'
      g.email   = 'camilacastro@example.com'
      g.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not guardian.save, 'Salvou registro inválido'
    assert_not_nil guardian.errors[:cpf], 'Faltou indicar problema no cpf'
  end
  
  test 'deve falhar ao salvar com cpf duplicado na mesma escola' do
    guardian = Guardian.new do |g|
      g.school  = schools(:one)
      g.name    = 'Aline Alves'
      g.cpf     = guardians(:one).cpf # o responsável :one é da escola :one
      g.phone   = '(85) 3030-3030'
      g.email   = 'alinealves@example.com'
      g.address = 'Rua Alfa, 10, Fortaleza - CE'
    end
    assert_not guardian.save, 'Salvou registro duplicado'
    assert_not_nil guardian.errors[:cpf], 'Faltou indicar problema no cpf'
  end
  
  test 'deve falhar ao salvar com cpf com valor de cnpj' do
    guardian = Guardian.new do |g|
      g.school  = schools(:one)
      g.name    = 'Camila Castro'
      g.cpf     = '23.722.118/0001-29' # a versão 0.2.0 da gem validates_cpf_cnpj dava falso-positivo com cnpj
      g.phone   = '(85) 5050-5050'
      g.email   = 'camilacastro@example.com'
      g.address = 'Rua Cravo, 10, Fortaleza - CE'
    end
    assert_not guardian.save, 'Salvou registro inválido'
    assert_not_nil guardian.errors[:cpf], 'Faltou indicar problema no cpf'
  end
  
end
