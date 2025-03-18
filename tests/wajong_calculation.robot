*** Settings ***

Documentation   Wajong uitkering berekening
Metadata        Wajong 2025 

Test Setup      Set Configuration
Test Teardown   Close Browser

Library         SeleniumLibrary
Library         String
Library         ../lib/Format.py
Library         ../expectations/Wajong.py

Resource        ../util/common_keywords.resource
Resource        ../page_objects/home_page.resource
Resource        ../page_objects/wajong_calculation.resource

*** Variables ***

${page_title}           Hoogte Wajong-uitkering in 2025
${page_title_postfix}   | UWV


*** Test Cases ***

Bereken hoogte uitkering voor leeftijd 18 jaar zonder andere inkomsten maar wel arbeidsvermogen
    Given Gebruiker start rekenhulp voor hoogte Wajong-uitkering
    When Leeftijd 18, geen andere inkomsten maar wel arbeidsvermogen wordt geselecteerd
    Then Bedragen zijn correct

Bereken hoogte uitkering voor leeftijd 20 jaar zonder andere inkomsten maar geen arbeidsvermogen
    Given Gebruiker start rekenhulp voor hoogte Wajong-uitkering
    When Leeftijd 20, geen andere inkomsten maar geen arbeidsvermogen wordt geselecteerd
    Then Bedragen zijn correct

Bereken hoogte uitkering voor leeftijd 22 jaar zonder andere inkomsten maar wel arbeidsvermogen
    Given Gebruiker start rekenhulp voor hoogte Wajong-uitkering
    When Leeftijd 22, geen andere inkomsten maar wel arbeidsvermogen wordt geselecteerd
    Then Bedragen zijn correct


*** Keywords ***

# Given

Gebruiker start rekenhulp voor hoogte Wajong-uitkering
    Open Site
    Accept Cookies       
    Search                      ${page_title}
    Wait Until Page Loaded    
    Click Link                  ${page_title} ${page_title_postfix}
    Wait Until Page Contains    Hoogte Wajong
    Click Start Button
    Page Should Contain         Uw gegevens

# When

Leeftijd ${leeftijd}, geen andere inkomsten maar ${arbeidsvermogen} arbeidsvermogen wordt geselecteerd
    Title Should Be            ${page_title} ${page_title_postfix}
    Set Test Variable           ${leeftijd}           ${leeftijd}      
    Set Test Variable           ${arbeidsvermogen}    ${arbeidsvermogen}   
    Select Leeftijd             ${leeftijd}
    Select Inkomen              geen
    Select Arbeidsvermogen      ${arbeidsvermogen}
    Click Next Step Button

# Then

Bedragen zijn correct
    Title Should Be             ${page_title} ${page_title_postfix}
    Page Should Contain         De uitkomst
    ${uitkering} =              Calculate Benefit    ${leeftijd}    ${arbeidsvermogen == "wel"}
    ${uitkering_formatted} =    Format Currency      ${uitkering}
    Element Should Contain      ${selector_uw_uitkering}            € ${uitkering_formatted} per maand
    Element Should Contain      ${selector_bruto_inkomsten}         € 0,00 per maand
    Element Should Contain      ${selector_totaal_bruto_inkomen}    € ${uitkering_formatted} per maand



