*** Settings ***

Documentation   Common keywords

Library     SeleniumLibrary
Resource    ../config.resource

*** Keywords ***

Open Site
    Log    Opening ${BASE_URL}...
    Set Screenshot Directory    screenshots
    Open Browser    ${BASE_URL}    ${BROWSER}

Accept Cookies
    Wait Until Element Is Visible    xpath://h2[contains(text(), "UWV gebruikt cookies")]
    Click Element    xpath://span[contains(text(), "Alles accepteren")]    
