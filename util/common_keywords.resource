*** Settings ***

Documentation   Common keywords

Library     SeleniumLibrary
Resource    ../config.resource

*** Keywords ***

Open Site
    Log                Opening ${BASE_URL} using ${BROWSER}...
    Open Browser       ${BASE_URL}    ${BROWSER}
    Maximize Browser Window

Accept Cookies
    Wait Until Element Is Visible    xpath://h2[contains(text(), "UWV gebruikt cookies")]
    Click Element    xpath://span[contains(text(), "Alles accepteren")]    

Set Configuration
    Set Screenshot Directory      ${BROWSER}
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}

