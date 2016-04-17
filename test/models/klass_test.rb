require 'test_helper'

class KlassTest < ActiveSupport::TestCase
  
  # Relações
  
  test 'deve pertencer a 1 escola' do
    assert_nothing_raised { Klass.new.school }
  end
  
  test 'deve pertencer a 1 unidade' do
    assert_nothing_raised { Klass.new.unit }
  end
  
  test 'deve estar associado a N professores' do
    assert_nothing_raised { Klass.new.teachers }
  end
  
  test 'deve estar associado a N alunos' do
    assert_nothing_raised { Klass.new.students }
  end
  
  # Válidos
  
  test 'deve salvar válido' do
    klass = Klass.new do |k|
      k.school = schools(:one)
      k.unit   = units(:one)
      k.title  = '6A'
    end
    assert klass.save, 'Falhou ao salvar registro válido'
  end
  
  test 'deve salvar válido com título usado em outra unidade' do
    klass = Klass.new do |k|
      k.school = schools(:two)
      k.unit   = units(:two)
      k.title  = '6A'
    end
    assert klass.save, 'Falhou ao salvar registro válido'
  end
  
  # Inválidos
  
  test 'deve falhar ao salvar sem escola' do
    klass = Klass.new do |k|
      # k.school = schools(:one)
      k.unit   = units(:one)
      k.title  = '6B'
    end
    assert_not klass.save, 'Salvou registro inválido'
    assert_not_nil klass.errors[:school_id], 'Faltou indicar problema na escola'
  end
  
  test 'deve falhar ao salvar sem unidade' do
    klass = Klass.new do |k|
      k.school = schools(:one)
      # k.unit   = units(:one)
      k.title  = '6B'
    end
    assert_not klass.save, 'Salvou registro inválido'
    assert_not_nil klass.errors[:unit_id], 'Faltou indicar problema na unidade'
  end
  
  test 'deve falhar ao salvar sem título' do
    klass = Klass.new do |k|
      k.school = schools(:one)
      k.unit   = units(:one)
      # k.title  = '6B'
    end
    assert_not klass.save, 'Salvou registro inválido'
    assert_not_nil klass.errors[:title], 'Faltou indicar problema no título'
  end
  
  test 'deve falhar ao salvar com título duplicado' do
    klass = Klass.new do |k|
      k.school = schools(:one)
      k.unit   = units(:one)
      k.title  = klasses(:one).title
    end
    assert_not klass.save, 'Salvou registro inválido'
    assert_not_nil klass.errors[:title], 'Faltou indicar problema no título'
  end
    
end
