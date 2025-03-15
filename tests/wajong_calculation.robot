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
    Wait Until Page Contains    Toont 1-10
    Page Should Contain Link    ${page_title} ${page_title_postfix}
    Click Link    ${page_title} ${page_title_postfix}
    Title Should Be   ${page_title} ${page_title_postfix}
    Click Start Button
    Page Should Contain    Uw gegevens

# When

Leeftijd ${leeftijd} wordt geselecteerd
    Click Element    xpath://bgl-radio[@test-id="inf_rekenhulp1wajong-harmonisatie_step1_question1_19"]
    Click Element    xpath://bgl-radio[@test-id="inf_rekenhulp1wajong-harmonisatie_step1_question2_no"]
    Click Element    xpath://bgl-radio[@test-id="inf_rekenhulp1wajong-harmonisatie_step1_question3_yes"]
    Press Keys    None    PAGE_DOWN    
    Click Element    xpath://bgl-button[@button-id="inf_rekenhulp1wajong-harmonisatie_step1next"]

# Then
