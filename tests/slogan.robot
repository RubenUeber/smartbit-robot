*** Settings ***
Documentation        Teste para verificar o Slogan da Smartbit na WebApp

Library        Browser

*** Test Cases ***
Deve exibir o Slogan na landing page
    New Browser    browser=chromium    headless=false

    New Page    http://localhost:3000
    Get Text    css=.headline h2    equal    Sua Jornada Fitness Começa aqui!    to be visible

    Sleep    2