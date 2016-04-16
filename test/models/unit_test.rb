require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  
  test 'deve salvar válido' do
    unit = Unit.new do |u|
      u.school  = schools(:one)
      u.title   = 'Unidade Sul'
      u.phone   = '(85) 3030-3030'
      u.email   = 'unidadesul@example.com'
      u.address = 'Rua Sul, 10, Fortaleza - CE'
    end
    assert unit.save, 'Falhou ao salvar registro válido'
  end
  
  test 'deve salvar válido sem campos opcionais' do
    unit = Unit.new do |u|
      u.school  = schools(:one)
      u.title   = 'Unidade Caucaia'
      # u.phone   = '(85) 3030-3030'
      # u.email   = 'unidadesul@example.com'
      # u.address = 'Rua Caucaia, 10, Fortaleza - CE'
    end
    assert unit.save, 'Falhou ao salvar registro válido'
  end
  
  test 'deve salvar com título usado em outra escola' do
    unit = Unit.new do |u|
      u.school  = schools(:two) # outra escola
      u.title   = 'Unidade Caucaia' # mesmo título da unidade acima
    end
    assert unit.save, 'Falhou ao salvar registro válido'
  end

  test 'deve falhar ao salvar sem título' do
    unit = Unit.new do |u|
      u.school  = schools(:one)
      # u.title   = 'Unidade Centro'
    end
    assert_not unit.save, 'Salvou registro inválido'
    assert_not_nil unit.errors[:title], 'Faltou indicar problema no título'
  end
  
  test 'deve falhar ao salvar com título duplicado na mesma escola' do
    unit = Unit.new do |u|
      u.school  = schools(:one)
      u.title   = units(:one).title # duplicado de test/models/units.yml
    end
    assert_not unit.save, 'Salvou registro inválido'
    assert_not_nil unit.errors[:title], 'Faltou indicar problema no título'
  end
  
end
