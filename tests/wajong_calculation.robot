*** Settings ***

Documentation   Wajong uitkering berekening
Metadata        Wajong 2025 

Library        SeleniumLibrary
Library    Dialogs
Resource        ../lib/common_keywords.resource
Resource        ../page_objects/home_page.resource
Resource        ../page_objects/wajong_calculation.resource

*** Variables ***
${page_title}      Hoogte Wajong-uitkering in 2025
${page_title_postfix}   | UWV


*** Test Cases ***

Bereken hoogte uitkering voor 18 jaar
    Given Gebruiker start rekenhulp voor hoogte Wajong-uitkering
    When Leeftijd 18 wordt geselecteerd


*** Keywords ***

# Given

Gebruiker start rekenhulp voor hoogte Wajong-uitkering
    Open Site
    Accept Cookies       
    Search    ${page_title}
    Pause Execution
    Page Should Contain Link    ${page_title} ${page_title_postfix}
    Click Link    ${page_title} ${page_title_postfix}
    Title Should Be   ${page_title} ${page_title_postfix}
    Click Start Button
    Page Should Contain    Uw gegevens

# When

Leeftijd ${leeftijd} wordt geselecteerd
    Select Radio Button    leeftijd    ${leeftijd}

# Then
