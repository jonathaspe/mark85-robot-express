*** Settings ***
Documentation        Signup

Resource        ../resources/base.robot
Library         FakerLibrary

*** Vaiables ***
#Aqui as variáveis são globais e todos os casos de testes poderão utilizá-las
    ${name}        Jonathas Santos
    ${email}       jonathassantos@yahoo.com.br
    ${password}    @123456

*** Test Cases ***

Deve poder cadastrar um novo usuário
    #exemplo sem usar o faker: ${name}    Set Variable   Jonathas Santos
    #variável específica deste caso de testes
    # ${name}        Name
    # ${email}       Free Email
    # ${password}    @123456

    Remove user from database    ${email} 

    Star Session

    Go To    http://localhost:3000/signup
    
    # Checkpoint
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    Faça seu cadastro

    Fill Text        id=name    ${name}
    Fill Text        id=email    ${email}
    Fill Text        id=password    ${password}

    Click            id=buttonSignup

    Wait For Elements State    css=.notice p    visible    5
    Get Text                   css=.notice p    equal      Boas vindas ao Mark85, o seu gerenciador de tarefas.


Não deve permitir o cadastro com o e-mail duplicado
    [Tags]    dup

    ${name}        Set Variable     Jonathas Santos
    ${email}       Set Variable     jonathassantos@yahoo.com.br
    ${password}    Set Variable     @123456
    
    Remove user from database        ${email}
    Insert user in database     ${name}    ${email}    ${password} 

    Star Session

    Go To    http://localhost:3000/signup
    
    # Checkpoint
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    Faça seu cadastro

    Fill Text        id=name    ${name}
    Fill Text        id=email    ${email}
    Fill Text        id=password    ${password}

    Click            id=buttonSignup

    Wait For Elements State    css=.notice p    visible    5
    Get Text                   css=.notice p    equal      Oops! Já existe uma conta com o e-mail informado.