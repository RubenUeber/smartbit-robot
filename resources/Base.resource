*** Settings ***
Documentation        Arquivo principal do projeto robot

Library        Browser
Library        libs/account.py
Library        JSONLibrary



Resource        pages/Landing.resource
Resource        pages/Welcome.resource
Resource        pages/Login.resource
Resource        pages/Accounts.resource

Resource        pages/components/Toast.resource
Resource        pages/components/BoxNotice.resource


*** Keywords ***
Start session
    New Browser    browser=chromium    headless=false
    New Page    http://localhost:3000


# Get Json fixture
#     [Arguments]        ${file_name}    ${scenario}

#     ${data}    Load Json From File
#     ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    
#     RETURN    ${data}[${scenario}]