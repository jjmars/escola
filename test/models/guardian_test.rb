require 'test_helper'

class GuardianTest < ActiveSupport::TestCase
  
  test 'deve salvar válido' do
    guardian = Guardian.new do |g|
      g.school  = schools(:one)
      g.units   << units(:one)
      g.name    = 'Aline Alves'
      g.cpf     = '900.112.815-70'
      g.phone   = '(85) 3030-3030'
      g.email   = 'alinealves@example.com'
      g.address = 'Rua Alfa, 10, Fortaleza - CE'
    end
    assert guardian.save, 'Falhou ao salvar registro válido'
  end
  
  test 'deve salvar válido sem campos opcionais' do
    guardian = Guardian.new do |g|
      g.school  = schools(:one)
      # g.units   << units(:one)
      g.name    = 'Breno Barreto'
      g.cpf     = '311.014.900-12'
      g.phone   = '(85) 4040-4040'
      g.email   = 'brenobarreto@example.com'
      g.address = 'Rua Beta, 10, Fortaleza - CE'
    end
    assert guardian.save, 'Falhou ao salvar registro válido'
  end
  
  test 'deve salvar válido com cpf usado em outra escola' do
    guardian = Guardian.new do |g|
      g.school  = schools(:two) # outra escola
      g.name    = 'Breno Barreto'
      g.cpf     = '311.014.900-12' # mesmo responsável do teste acima
      g.phone   = '(85) 4030-3030'
      g.email   = 'brenobarreto@example.com'
      g.address = 'Rua Beta, 10, Fortaleza - CE'
    end
    assert guardian.save, 'Falhou ao salvar registro válido'
  end
  
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
  
end
