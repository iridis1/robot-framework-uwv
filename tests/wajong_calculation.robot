*** Settings ***

Documentation   Wajong uitkering berekening
Metadata        Wajong 2025 

Library        SeleniumLibrary
Library        String
Library        ../lib/Format.py

Resource        ../util/common_keywords.resource
Resource        ../page_objects/home_page.resource
Resource        ../page_objects/wajong_calculation.resource
Resource        ../data/wajong.resource

*** Variables ***
${page_title}      Hoogte Wajong-uitkering in 2025
${page_title_postfix}   | UWV


*** Test Cases ***

Bereken hoogte uitkering voor 18 jaar zonder andere inkomsten maar wel arbeidsvermogen
    Given Gebruiker start rekenhulp voor hoogte Wajong-uitkering
    When Leeftijd 18, geen andere inkomsten maar wel arbeidsvermogen wordt geselecteerd
    Then Bedragen zijn correct

Bereken hoogte uitkering voor 20 jaar zonder andere inkomsten maar wel arbeidsvermogen
    Given Gebruiker start rekenhulp voor hoogte Wajong-uitkering
    When Leeftijd 20, geen andere inkomsten maar wel arbeidsvermogen wordt geselecteerd
    Then Bedragen zijn correct


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

Leeftijd ${leeftijd}, geen andere inkomsten maar wel arbeidsvermogen wordt geselecteerd
    Set Test Variable    ${age}    ${leeftijd}        
    Click Element    xpath://bgl-radio[@test-id="inf_rekenhulp1wajong-harmonisatie_step1_question1_${leeftijd}"]/div/div/label
    Click Element    xpath://bgl-radio[@test-id="inf_rekenhulp1wajong-harmonisatie_step1_question2_no"]/div/div/label
    Click Element    xpath://bgl-radio[@test-id="inf_rekenhulp1wajong-harmonisatie_step1_question3_yes"]/div/div/label
    Click Element    css:bgl-button[button-id="inf_rekenhulp1wajong-harmonisatie_step1next"]

# Then

Bedragen zijn correct
    Title Should Be   ${page_title} ${page_title_postfix}
    Page Should Contain    De uitkomst
    IF    ${age} == 18
        ${uitkering}    Format Currency    ${UITKERING_LEEFTIJD_18_JAAR_GEEN_INKOMSTEN_WEL_ARBEIDSVERMOGEN}
    ELSE IF    ${age} == 20
        ${uitkering}    Format Currency    ${UITKERING_LEEFTIJD_20_JAAR_GEEN_INKOMSTEN_WEL_ARBEIDSVERMOGEN}
    END

    Element Should Contain    xpath://dt[text()="Uw uitkering"]/following-sibling::dd    ${uitkering} per maand
    Element Should Contain    xpath://dt[text()="Uw bruto-inkomsten"]/following-sibling::dd    € 0,00 per maand
    Element Should Contain    xpath://dt[text()="Totale bruto-inkomen"]/following-sibling::dd    ${uitkering} per maand


