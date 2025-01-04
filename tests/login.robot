*** Settings ***
Documentation        Cenários de testes do login SAC

Resource        ../resources/Base.resource

Test Setup       Start session
Test Teardown    Take Screenshot    
#Library          SeleniumLibrary
Library          Browser
Library          Process

*** Test Cases ***
Deve logar como gestor da academia
    Go to login pages
    Submit login form    sac@smartbit.com    pwd123
    User is logged in    sac@smartbit.com
    

Não deve logar com senha incorreta
    #[Tags]    inv_pass

    Browser.Go to    http://localhost:3000/login
    Submit login form    sac@smartbit.com    abc123

    Toast should be      As credenciais de acesso fornecidas são inválidas. Tente novamente!


Não deve logar com e-mail não cadastrado
   # [Tags]    inv_pass

    Go to login pages
    Submit login form    404sac@smartbit.com    abc123

    Toast should be      As credenciais de acesso fornecidas são inválidas. Tente novamente!


Tentativa de login com dados incorretos
    [Tags]        temp
    [Template]    Login with verify notice
    ${EMPTY}            ${EMPTY}                Os campos email e senha são obrigatórios.
    sac@smartbit.com    ${EMPTY}                Os campos email e senha são obrigatórios.
    ${EMPTY}            abc123                  Os campos email e senha são obrigatórios.
    www.smartbit.com    pwd123                  Oops! O email informado é inválido
    sac@gmail.com       pwd123                  Oops! O email informado é inválido
    adaseawewer         pwd123                  Oops! O email informado é inválido
    awerfewa@gmail.com  pwd123                  Oops! O email informado é inválido




*** Keywords ***
Login with verify notice
    [Arguments]        ${email}        ${password}        ${output_message}

    Go to login pages
    Submit login form    ${email}    ${password}
    Notice should be    ${output_message}
