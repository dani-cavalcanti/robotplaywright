*** Settings ***
Library     Browser
Library     FakerLibrary
Library     DateTime


*** Variables ***
${BROWSER}              chromium
${HEADLESS}             ${true}
${SITE_SERVER_REST}     https://front.serverest.dev/


*** Keywords ***
Abrir o navegador
    New Browser    browser=${BROWSER}
    ...            headless=${HEADLESS}

    ${TRACE_NAME}     FakerLibrary.Uuid 4
    ${NOW}            Get Current Date    result_format=%d-%m-%Y_%H%M%S
    New Context       viewport={'width': 1200, 'height': 800}
    ...               tracing=${OUTPUT_DIR}/evidencies/traces/${NOW}/${TRACE_NAME}.zip
    ...               recordVideo={'dir':'${OUTPUT_DIR}/evidencies/videos/${NOW}'}

Ir para o site Serve Rest Front
    New Page    url=${SITE_SERVER_REST}
    ${title}    Get Title    ==    Front - ServeRest
    Log    ${title}
    Sleep    5s

Preencher os dados do novo usuário e cadastrar
    #    Click    css=.btn-link
 #    Click    text="Cadastre-se"
    Click    css=a[data-testid='cadastrar']
    ${EMAIL}    FakerLibrary.Email
    Set Test Variable    ${EMAIL}
    Fill Text    css=input[data-testid='nome']    Dani Cavalcanti
    Fill Text    css=input[data-testid='email']    ${EMAIL}
    Fill Text    css=input[data-testid='password']    pwd123
    Check Checkbox    css=input[data-testid='checkbox']
    # Click    css=button[data-testid='cadastrar']
    Click    xpath=//*[@id="root"]//button >> text="Cadastrar"

Conferir usuário cadastrado com sucesso
    #    Wait For Elements State    h1    visible
    Get Text    h1    ==    Bem Vindo Dani Cavalcanti
    Get Element States    css=button[data-testid='logout']    validate    value & visible

#Desafio proposto em aula

Cadastrar novo usuário
    Abrir o navegador
    Ir para o site Serve Rest Front
    Preencher os dados do novo usuário e cadastrar
    Conferir usuário cadastrado com sucesso

Acessar a Lista de usuários
    Click    css=a[data-testid='listarUsuarios']

Conferir que o usuário aparece na listagem
    ${elemento}    Get Table Cell Element    css=table    "Nome"    "${EMAIL}"
    ${usuario_nome}    Get Text    ${elemento}    ==    Dani Cavalcanti
    Highlight Elements    ${elemento}
    Take Screenshot    fullPage=${true}

Cadastrar um novo produto
    Click    css=a[data-testid='cadastrarProdutos']
    ${PRODNAME}    FakerLibrary.Word
    ${PRECO}    FakerLibrary.Building Number
    ${DESCRICAO}    FakerLibrary.Text
    Set Test Variable    ${PRODNAME}
    Set Test Variable    ${DESCRICAO}
    Fill Text    css=input[data-testid='nome']    ${PRODNAME}
    Fill Text    css=input[data-testid='preco']    ${PRECO}
    Fill Text    css=textarea[data-testid='descricao']    ${DESCRICAO}
    Fill Text    css=input[data-testid='quantity']    1
    Click    css=button[data-testid='cadastarProdutos']

Conferir que o produto aparece na listagem
    ${elemento}    Get Table Cell Element    css=table    "Nome"    "${DESCRICAO}"
    ${usuario_nome}    Get Text    ${elemento}    ==    ${PRODNAME}
    Highlight Elements    ${elemento}
    Take Screenshot    fullPage=${true}
