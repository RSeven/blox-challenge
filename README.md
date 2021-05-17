# Desafio Blox
Descrição: https://github.com/sistema-blox/desafio

## Requisitos funcionais:
* Deve ser possível criar, listar e excluir salas;
* Os horários disponíveis para reserva devem estar dentro do horário comercial (8:00 as 18:00);
* O usuário não conseguirá reservar a sala se a mesma já estiver alocada à outro usuário;
* Criação de uma tela de agenda onde usuários poderão visualizar / reservar todos os horários disponíveis;

## 1. Como usar o sistema
### Login
Como cadastro não era um dos requisitos do teste, existe um seed que cria três usuários, suficientes para testar as funcionalidades. São eles:
* user_1@example.com:user_1
* user_2@example.com:user_2
* moderator@example.com:moderator

### Gerenciamento de Salas
Os usuários do sistema são divididos em duas **roles**: *user* e *moderator*. Apenas moderadores podem criar, editar e excluir salas.

Nota: Essa parte não ficou muito clara na especificação. Acredito que no fim das contas a ideia era que os próprios usuários criassem salas e agendassem horários, mas não é bem como funcionaria num exemplo real, então dei um passo a mais.

### Gerenciamento de Eventos
Qualquer usuário pode visualizar e criar eventos em qualquer sala.

Apenas o dono do evento pode editar ou excluir seu evento.

Um evento válido precisa:
* Ter um horário de início no futuro
* Ter um horário de fim depois do horário de início
* Estar dentro do horário comercial (8:00 às 18:00)
* Não conflitar com o horário de outro evento na mesma sala

## 2. Como foi feito
### Login
O login foi feito utilizando Devise. O acesso para usuários deslogados é bloqueado utilizando o próprio método do Devise `authenticate_user!`.

Tenho total consciência de que Devise foi um overkill aqui, mas para fins de avaliação achei interessante utilizar, já que devise é tão popular.

### Gerenciamento de Salas
Para evitar que usuários comuns possam criar, editar ou deletar salas existem dois bloqueios. Um é no próprio front-end, que esconde os links das ações se o usuário não for moderador. Outro é no back-end, que checa se o usuário é um moderador num `before_action`. O método utilizado para checar se o usuário é um moderador está no ApplicationController e se chama `:moderator_only!`.

### Gerenciamento de Eventos
Para garantir que apenas o dono do evento possa executar ações nele existem dois bloqueios, como no gerenciamento de salas. As ações são escondidas no front-end se o usuário não for dono do respectivo evento. Além disso, no back-end checamos se o usuário é o dono do evento num `before action`. O método utilizado para checar se o usuário é dono do evento está no próprio EventsController, já que é um comportamento inerente dos eventos mesmo, e se chama `owner_only!`.

#### Validação do horário de início e fim
Para isso foram usadas duas gems: date_validator e business.

A date_validator permite que eu verifique se uma data está dentro de um determinado range, enquanto a business facilita o gerenciamento do horário comercial.

Unindo as duas é possível escrever:
`validates :start_time, date: { 
  after_or_equal_to: Proc.new { |obj| [Time.now, Time.beginning_of_workday(obj.start_time)].max },
  before: Proc.new { |obj| Time.end_of_workday(obj.start_time) }
}`

`validates :end_time, date: {
  after: :start_time,
  before_or_equal_to: Proc.new { |obj| Time.end_of_workday(obj.start_time || obj.end_time) }
}`

É importante verificar que na validação do `end_time`, o final do dia de trabalho é baseado no `start_time`. Dessa forma, não é possível ter eventos que atravessem de um dia para o outro.

#### Checagem de disponibilidade
Além de respeitar o horário comercial, a sala não pode estar ocupada no horário escolhido. Por isso também fazemos uma checagem utilizando o método `classroom_availability` presente em `models/event.rb`.

#### A agenda
A tela de agenda foi gerada com a gem simple_calendar.
