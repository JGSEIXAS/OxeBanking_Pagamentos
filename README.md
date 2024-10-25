# Oxebanking Pagamentos

**Oxebanking Pagamentos** é o módulo de pagamentos desenvolvido como parte do projeto final de Internet Banking "Oxebanking" na disciplina **Conceitos de Linguagem e Programação** (CLP), lecionada no Instituto de Computação da **Universidade Federal de Alagoas (UFAL)**.

## Descrição

Este módulo é responsável por gerenciar transações de pagamento, incluindo funcionalidades como criação, listagem e exibição de pagamentos realizados. O objetivo é facilitar as operações financeiras dos usuários do sistema de Internet Banking **Oxebanking**.

## Tecnologias Utilizadas

- **Elixir**: Linguagem de programação funcional usada para desenvolvimento.
- **Phoenix**: Framework web utilizado para construir a API.
- **Ecto**: Biblioteca para interações com o banco de dados.
- **PostgreSQL**: Sistema de gerenciamento de banco de dados relacional utilizado para armazenamento de dados.

## Integrantes

- **João Gabriel Seixas Santos**
- **Yuck Arthur Ferreira Silva**

## Professor

- **Rafael de Amorim Silva**

## Requisitos

Antes de executar o projeto, verifique se você possui as seguintes tecnologias instaladas:

- Elixir >= 1.12
- Phoenix >= 1.5
- PostgreSQL >= 13.x

## Instalação e Configuração

1. Clone este repositório:

    ```bash
    git clone https://github.com/SEU_USUARIO/Oxebanking_Pagamentos.git
    cd Oxebanking_Pagamentos
    ```

2. Instale as dependências:

    ```bash
    mix deps.get
    ```

3. Crie e migre o banco de dados:

    ```bash
    mix ecto.create
    mix ecto.migrate
    ```

4. Inicie o servidor:

    ```bash
    mix phx.server
    ```

Agora você pode acessar a aplicação em `http://localhost:4000`.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para enviar pull requests.

## Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
