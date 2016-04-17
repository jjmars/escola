class HomeController < ApplicationController
  def index
    # Na página principal, é preciso contar turmas, professores, alunos e responsáveis para cada unidade. Pode-se usar `includes` e contar os resultados ou, alternativamente, `count` de cada relação de cada unidade. Para decidir, fiz as seguintes considerações:

    # `includes` executa apenas 4 queries (turmas, professores, alunos e responsáveis)
    # `count` em loop executa N*4 queries (turmas, professores, alunos e responsáveis para cada unidade)
    
    # `includes` retorna centenas de tuplas inteiras que não serão utilizadas (o que interessa é contar o total)
    # `count` retorna apenas inteiros (N*4 inteiros)

    # Apesar do `count` gerar N vezes mais queries, acredito que o trade-off da transferência de dados reduzida entre aplicação e banco vale a pena. Portanto optei por usar `count`, mas deixo a opção pelo `includes` comentada abaixo caso prove-se uma opção melhor futuramente:
    
    # @units = @school.units.includes(:klasses, :teachers, :students, :guardians)
  end
end
