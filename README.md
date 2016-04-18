# Escola


## Descrição

Ferramenta administrativa para escolas. Gerencie unidades, turmas, professores, alunos e responsáveis.

## Deploy

### seeds.rb

Para popular o banco com dados amostrais, execute `rake db:seed`.

### Variáveis de ambiente

É preciso criar as seguintes variáveis de ambiente:

* DOMAIN
* SMTP_ADDRESS
* SMTP_PORT
* SMTP_USERNAME
* SMTP_PASSWORD

Estas variáveis configuram o ActionMailer em `config/application.rb`:

    config.action_mailer.smtp_settings = {
        domain:               ENV['DOMAIN'],
        address:              ENV['SMTP_ADDRESS'],
        port:                 ENV['SMTP_PORT'],
        user_name:            ENV['SMTP_USERNAME'],
        password:             ENV['SMTP_PASSWORD'],
        authentication:       'plain',
        enable_starttls_auto: true
    }

Sugere-se a utilização do plugin [rbenv-vars](https://github.com/rbenv/rbenv-vars).

## Notas

### Contagem de relações na página principal

Na página principal, é preciso contar turmas, professores, alunos e responsáveis para cada unidade. Pode-se usar `includes` e contar os resultados ou, alternativamente, `count` de cada relação de cada unidade. Para decidir, fiz as seguintes considerações:

* `includes` executa apenas 4 queries (turmas, professores, alunos e responsáveis)
* `count` em loop executa N*4 queries (turmas, professores, alunos e responsáveis para cada unidade)

* `includes` retorna centenas de tuplas inteiras que não serão utilizadas (o que interessa é contar o total)
* `count` retorna apenas inteiros (N*4 inteiros)

Apesar do `count` gerar N vezes mais queries, acredito que o trade-off da transferência de dados reduzida entre aplicação e banco vale a pena. Portanto optei por usar `count`, mas deixo a opção pelo `includes` comentada em `home_controller.rb` caso prove-se uma opção melhor futuramente:

    @units = @school.units.includes(:klasses, :teachers, :students, :guardians)

### Chaves estrangeiras em todos os modelos

Os modelos de Turma, Aluno, Professor e Responsável têm relações para Escola e/ou Unidade. Certamente seria possível eliminar essas relações em alguns modelos e encontrá-las por encadeamento (exemplo: *Responsável >> Aluno >> Unidade >> Escola*), mas optei por mantê-las para reduzir a transferência de dados gerada por queries de autorização.

Por exemplo, considerando o seguinte cenário:

* O usuário é administrador da escola id=11
* Há um responsável id=1 cujo aluno é da escola id=11
* Há um responsável id=3 cujo aluno é da escola id=33

Se o administrador abrir a URL `/guardians/1`, ele terá acesso (200). Mas se abrir `/guardians/3`, não será autorizado (401). A autorização é feita sem queries, somente com a chave estrangeira da escola do responsável:

    if session['school_id'] != @guardian.school_id # nenhuma query
        redirect_to root_path, status: unauthorized
    end

Sem chave estrangeira, seriam necessárias várias queries para atingir o mesmo objetivo, podendo se extender até o seguinte:

    if session['school_id'] != @guardian.students.first.unit.school_id # 2 queries
        redirect_to root_path, status: :unauthorized
    end

Como é necessário autorizar praticamente todo request feito pelo usuário, eliminar queries de autorização reduz a transferência de dados entre a aplicação e o banco a longo prazo.

## Testes

Os testes cobrem os modelos, suas relações e registros válidos e inválidos.
Para executar: `rake test test/models/*`

Testes de controllers ainda precisam ser elaborados e/ou corrigidos.

## gitignore

Inclui arquivos e diretórios comumente ignorados para:

* rbenv
* ruby
* rails
* osx
* linux
* windows
* textmate
* rubymine
* sublimetext
* emacs
