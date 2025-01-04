*** Settings ***
Documentation        Suite de testes de adesões de planos

Resource        ../resources/Base.resource

Test Setup           Start session
Test Teardown        Take Screenshot
Library    ../resources/libs/database.py
#Library    SeleniumLibrary

*** Test Cases ***
Deve poder realizar uma nova adesão

    ${accounts}        Create Dictionary
    ...        name=Paulo Cintura
    ...        email=paulo@cintura.com.br
    ...        cpf=14278623038
       
    ${plan}        Set Variable    Plano Black

    
    ${card}        Create Dictionary
    ...        number=4592443960065975
    ...        holder=Paulo Cintura
    ...        month=12
    ...        year=2030
    ...        cvv=123

    Delete Account By Email    ${accounts}[email]  #delete cascade no banco de dados
    Insert Account             ${accounts}
    

    Go to login pages
    Submit login form    sac@smartbit.com    pwd123
    User is logged in    sac@smartbit.com

    Go to memberships
    Go to memberships form
    Select account             ${accounts}[name]    ${accounts}[cpf]
    Select plan                ${plan}
    Fill payment card          ${card}    ${card}[holder]    ${card}[month]    ${card}[year]    ${card}[cvv]          
   

Não deve gerar matrícula duplicada
    [Tags]    Dup
    ${accounts}        Create Dictionary
    ...        name=Paulo Cintura
    ...        email=paulo@cintura.com.br
    ...        cpf=14278623038
       
    ${plan}        Set Variable    Plano Black

    
    ${card}        Create Dictionary
    ...        number=4592443960065975
    ...        holder=Paulo Cintura
    ...        month=12
    ...        year=2030
    ...        cvv=123

    # Delete Account By Email    ${accounts}[email]  #delete cascade no banco de dados
    # Insert Account             ${accounts}
    
    
    Go to login pages
    Submit login form    sac@smartbit.com    pwd123
    User is logged in    sac@smartbit.com

    Go to memberships
    Go to memberships form
    Select account             ${accounts}[name]    ${accounts}[cpf]
    Select plan                ${plan}
    Fill payment card          ${card}[card]    ${card}[holder]    ${card}[month]    ${card}[year]    ${card}[cvv] 
    Toast should be    O usuário já possui matrícula.

    Sleep    5

    #ou
    #Click    css=div[class$=option] >> text=Plano Black        Neste caso lê-se: class cuja o 
    

    # ${html}        Get Page Source     #pega na fonte o input do usuário
    # Log    ${html}                    #guarda essa variável no log par depois ser usado


*** Keywords ***
Go to memberships 
    Click    css=a[href="/memberships"]

    Wait For Elements State    css=h1 >> text=Matrículas
    ...        visible    5
    
Go to memberships form
    Click        css=a[href="/memberships/new"]
    Wait For Elements State    css=h1 >> text=Nova matrícula
    ...        visible    5
    
Select account
    [Arguments]        ${name}        ${cpf}

    Fill Text    css=input[aria-label=select_account]        ${name}
    Click        css=[data-testid="${cpf}"]
   
Select plan
    [Arguments]        ${plan_name}

    Fill Text    css=input[aria-label="select_plan"]    ${plan_name}
    Click        css=div[id*=option] >> text=${plan_name}

    # Fill Text    css=input[name="card_number"]    4592443960065975
    # Fill Text    css=input[name="card_holder"]    Paulo Cintura
    # Fill Text    css=input[name="card_month"]     12
    # Fill Text    css=input[name="card_year"]      2030
    # Fill Text    css=input[name="card_cvv"]       123

    # Click    css=button[type="submit"] >> text=Cadastrar

    # Sleep    5

    # Toast should be    Matrícula cadastrada com sucesso.

Fill payment card
    [Arguments]        ${card}        ${holder}        ${month}        ${year}        ${cvv}
    
    Fill Text    css=input[name=card_number]    ${card}[number]
    Fill Text    css=input[name=card_holder]    ${card}[holder]
    Fill Text    css=input[name=card_month]     ${card}[month]
    Fill Text    css=input[name=card_year]      ${card}[year]
    Fill Text    css=input[name=card_cvv]       ${card}[cvv]