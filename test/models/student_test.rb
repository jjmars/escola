require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  
  test 'deve salvar válido' do
    student = Student.new do |s|
      s.guardian   = guardians(:one)
      s.school     = schools(:one)
      s.unit       = units(:one)
      s.klasses    << klasses(:one)
      s.name       = 'Ana Alves'
      s.enrollment = '100111'
      s.phone      = '(85) 3030-3030'
      s.email      = 'anaalves@example.com'
      s.address    = 'Rua Alfa, 10, Fortaleza - CE'
    end
    assert student.save, 'Falhou ao salvar registro válido'
  end
  
  test 'deve salvar válido sem campos opcionais' do
    student = Student.new do |s|
      s.guardian   = guardians(:one)
      s.school     = schools(:one)
      s.unit       = units(:one)
      # s.klasses    << klasses(:one)
      s.name       = 'Augusto Alves'
      s.enrollment = '100222'
      # s.phone      = '(85) 30303-3030'
      # s.email      = 'algustoalves@example.com'
      # s.address    = 'Rua Alfa, 10, Fortaleza - CE'
    end
    assert student.save, 'Falhou ao salvar registro válido'
  end
  
  test 'deve salvar válido com matrícula usada em outra escola' do
    student = Student.new do |s|
      s.guardian   = guardians(:two)
      s.school     = schools(:two) # outra escola
      s.unit       = units(:two)
      s.name       = 'José Silva'
      s.enrollment = students(:one).enrollment # o aluno :one é da escola :one
    end
    assert student.save, 'Falhou ao salvar registro válido'
  end
  
  test 'deve falhar ao salvar sem responsável' do
    student = Student.new do |s|
      # s.guardian   = guardians(:one)
      s.school     = schools(:one)
      s.unit       = units(:one)
      s.name       = 'Alcides Alves'
      s.enrollment = '100333'
    end
    assert_not student.save, 'Salvou registro inválido'
    assert_not_nil student.errors[:guardian_id], 'Faltou indicar problema no responsável'
  end
  
  test 'deve falhar ao salvar sem escola' do
    student = Student.new do |s|
      s.guardian   = guardians(:one)
      # s.school     = schools(:one)
      s.unit       = units(:one)
      s.name       = 'Alcides Alves'
      s.enrollment = '100333'
    end
    assert_not student.save, 'Salvou registro inválido'
    assert_not_nil student.errors[:school_id], 'Faltou indicar problema na escola'
  end
  
  test 'deve falhar ao salvar sem unidade' do
    student = Student.new do |s|
      s.guardian   = guardians(:one)
      s.school     = schools(:one)
      # s.unit       = units(:one)
      s.name       = 'Alcides Alves'
      s.enrollment = '100333'
    end
    assert_not student.save, 'Salvou registro inválido'
    assert_not_nil student.errors[:unit_id], 'Faltou indicar problema na unidade'
  end
  
  test 'deve falhar ao salvar sem nome' do
    student = Student.new do |s|
      s.guardian   = guardians(:one)
      s.school     = schools(:one)
      s.unit       = units(:one)
      # s.name       = 'Alcides Alves'
      s.enrollment = '100333'
    end
    assert_not student.save, 'Salvou registro inválido'
    assert_not_nil student.errors[:name], 'Faltou indicar problema no nome'
  end
  
  test 'deve falhar ao salvar sem matrícula' do
    student = Student.new do |s|
      s.guardian   = guardians(:one)
      s.school     = schools(:one)
      s.unit       = units(:one)
      s.name       = 'Alcides Alves'
      # s.enrollment = '100333'
    end
    assert_not student.save, 'Salvou registro inválido'
    assert_not_nil student.errors[:enrollment], 'Faltou indicar problema na matrícula'
  end
  
  test 'deve falhar ao salvar com matrícula duplicada na mesma escola' do
    student = Student.new do |s|
      s.guardian   = guardians(:one)
      s.school     = schools(:one)
      s.unit       = units(:one)
      s.name       = 'Ana Alves'
      s.enrollment = students(:one).enrollment # o aluno :one é da escola :one
    end
    assert_not student.save, 'Salvou registro inválido'
    assert_not_nil student.errors[:enrollment], 'Faltou indicar problema na matrícula'
  end
end
