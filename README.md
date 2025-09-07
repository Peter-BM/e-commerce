# Projeto – API de Carrinho


Olá! Este é o meu projeto de desafio técnico, desenvolvido em **Ruby on Rails (API-only)** com **PostgreSQL** e **Sidekiq**.  
O objetivo é implementar uma API de carrinho de compras com endpoints para adicionar, listar, atualizar e remover itens, além de um job responsável por marcar carrinhos abandonados e excluí-los.

---

## Instruções básicas para execução dos endpoints
- **POST `/cart`**: cria o carrinho (caso não exista) e adiciona um produto.

  Body exemplo:
    ```
    {
    "product_id": 1,
    "quantity": 2
    }
    ```

- **GET `/cart`**: lista os produtos do carrinho atual.  
- **POST `/cart/add_item`**: incrementa a quantidade de um produto já existente ou adiciona um novo produto ao carrinho.  

  Body exemplo:
    ```
    {
    "product_id": 1,
    "quantity": 2
    }
    ```

- **DELETE `/cart/:product_id`**: remove um produto do carrinho.  

> Observação: a API utiliza **sessão** para identificar o carrinho.  
Ao testar via `curl` ou ferramentas como Postman, lembre-se de manter o **cookie de sessão** entre as requisições para simular o mesmo carrinho.

---

## Sobre o job
Foi implementado um **job** que:
- Marca carrinhos como **abandonados** se ficarem inativos por mais de **3 horas**.  
- Exclui carrinhos abandonados há mais de **7 dias**.  

⚠️ O job foi criado, mas **ainda não foi testado adequadamente em produção**.

---

## Conclusão
Esse projeto cobre os requisitos principais do desafio técnico, com endpoints funcionais e um job de manutenção dos carrinhos.  
Futuramente, pretendo refinar os testes automatizados, validar melhor o job e documentar cenários de erro mais detalhados.

---
