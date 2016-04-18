# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Escola
@school = School.create do |s|
  s.title   = "Escola #{Forgery('name').company_name}"
  s.cnpj    = CNPJ.generate
  s.phone   = Forgery('address').phone
  s.email   = Forgery('internet').email_address
  s.address = Forgery('address').street_address
end

# Unidades
@units = []
for i in 1..5 do
  @units << Unit.create do |u|
    u.school  = @school
    u.title   = "Unidade #{Forgery('name').company_name}"
    u.phone   = Forgery('address').phone
    u.email   = Forgery('internet').email_address
    u.address = Forgery('address').street_address
  end
end

# Turmas
@klasses = []
@units.each do |u|
  for i in 2..9 do
    @klasses << Klass.create do |k|
      k.school = @school
      k.unit   = u
      k.title  = "#{i / 2}-#{i % 2.0 == 0 ? 'A' : 'B' }"
    end
  end
end

# Responsáveis
@guardians = []
for i in 1..400 do
  @guardians << Guardian.create do |g|
    g.school  = @school
    g.name    = Forgery('name').full_name
    g.cpf     = CPF.generate
    g.phone   = Forgery('address').phone
    g.email   = Forgery('internet').email_address
    g.address = Forgery('address').street_address
  end
end

# Alunos
@students = []
for i in 1..500 do
  s_unit = @units.sample # unidade do aluno (aleatória)
  s_klasses = @klasses.select{ |k| k.unit_id == s_unit.id }.sample(rand 1..2) # turmas do aluno (aleatórias dentre todas da unidade do aluno)
  
  @students << Student.create do |s|
    s.school     = @school
    s.unit       = s_unit
    s.klasses    = s_klasses
    s.guardian   = @guardians.sample # responsável (aleatório)
    s.name       = Forgery('name').full_name
    s.enrollment = CPF.generate
    s.phone      = Forgery('address').phone
    s.email      = Forgery('internet').email_address
    s.address    = Forgery('address').street_address
  end
end

# Professores
@teachers = []
for i in 1..50 do
  @teachers << Teacher.create do |t|
    t.school  = @school
    t.klasses << @klasses.sample(rand 10) # turmas do professor (aleatórias)
    t.name    = Forgery('name').full_name
    t.cpf     = CPF.generate
    t.phone   = Forgery('address').phone
    t.email   = Forgery('internet').email_address
    t.address = Forgery('address').street_address
  end
end