*** Settings ***
Documentation        hello robot

#Library    Browser  - arquivo base.resource e landing.resource já importam essa biblioteca. Por isso não é necessário tê-la aqui
#Library    OperatingSystem

Resource        ../resources/base.resource

Test Setup        Start session
Test Teardown     Take Screenshot        
 

*** Test Cases ***
Deve iniciar o cadastro do cliente
    #preparação massa de teste randômica
    
    ${account}    Get Fake Account    

   
    Submit signup form    ${account}
    Verify welcome message
    
    
    #verificação
    Wait For Elements State    text=Falta pouco para fazer parte da família Smartbit!
    ...    visible
    ...    10
    ... 

*** Test Cases ***
# Deve iniciar o cadastro do cliente 
    #preparação massa de teste FIXA
    # [Tags]        smoke
    
    # ${account}      Create Dictionary
    # ...             name=Ruben Ueber
    # ...             email=rubentest@yahoo.com
    # ...             cpf=18684174330


    # Delete Account By Email    ${account}[Email]
   
    # Submit signup form    ${account}
    # Verify welcome message
    
    
    # #verificação
    # Wait For Elements State    text=Falta pouco para fazer parte da família Smartbit!
    # ...    visible
    # ...    10
    

Tentativa de cadastro
    [Template]    Attempt signup
    ${EMPTY}    ruben@gmail.com        34779753678    Por favor informe o seu nome completo
    Ruben Ueber    ${EMPTY}            34779753678    Por favor, informe o seu melhor e-mail
    Ruben Ueber    ruben@gmail.com     ${EMPTY}       Por favor, informe o seu CPF
    Ruben Ueber    ruben$gmail.com     34779753678    Oops! O email informado é inválido
    Ruben Ueber    rubengmail.com      34779753678    Oops! O email informado é inválido
    Ruben Ueber    dsg#$%%$            34779753678    Oops! O email informado é inválido
    Ruben Ueber    ruben@gmail         34779753678    Oops! O email informado é inválido 
    Ruben Ueber    ruben@gmail.com     3477975367a    Oops! O CPF informado é inválido
    Ruben Ueber    ruben@gmail.com     2              Oops! O CPF informado é inválido
    Ruben Ueber    ruben@gmail.com     @#$#@          Oops! O CPF informado é inválido
    Ruben Ueber    ruben@gmail.com     efer           Oops! O CPF informado é inválido

*** Keywords ***
Attempt signup
    [Arguments]    ${name}    ${email}    ${cpf}    ${output_message}

    ${account}        Create Dictionary
    ...    name=${name}
    ...    email=${email}
    ...    cpf=${cpf}

    
    Submit signup form    ${account}
    Notice should be    ${output_message}