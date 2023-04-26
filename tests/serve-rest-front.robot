*** Settings ***
Resource    ../resources/serve-rest-front.resource

Test Teardown        Close Context

*** Test Cases ***
Login com sucesso ServeRest com sucesso
    Abrir o navegador
    Ir para o site Serve Rest Front
    Preencher os dados do novo usuário e cadastrar
    Conferir usuário cadastrado com sucesso

Desafio: Conferir se o novo usuário é mostrado na listagem de usuários
    Cadastrar novo usuário
    Acessar a Lista de usuários
    Conferir que o usuário aparece na listagem

Desafio: Cadastrar um novo produto e validar se o mesmo é exibido na listagem de produtos
    Cadastrar novo usuário
    Cadastrar um novo produto
    Conferir que o produto aparece na listagem
