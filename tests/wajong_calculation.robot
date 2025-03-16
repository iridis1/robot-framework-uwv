*** Settings ***

Documentation   Wajong uitkering berekening
Metadata        Wajong 2025 

Test Teardown   Close Browser

Library         SeleniumLibrary
Library         String
Library         ../lib/Format.py
Library         ../expectations/Wajong.py

Resource        ../util/common_keywords.resource
Resource        ../page_objects/home_page.resource
Resource        ../page_objects/wajong_calculation.resource

*** Variables ***

${page_title}      Hoogte Wajong-uitkering in 2025
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
    Search    ${page_title}
    Wait Until Page Contains    Toont 1-10
    Page Should Contain Link    ${page_title} ${page_title_postfix}
    Click Link    ${page_title} ${page_title_postfix}
    Title Should Be   ${page_title} ${page_title_postfix}
    Click Start Button
    Page Should Contain    Uw gegevens

# When

Leeftijd ${leeftijd}, geen andere inkomsten maar ${arbeidsvermogen} arbeidsvermogen wordt geselecteerd
    Set Test Variable    ${age}    ${leeftijd}      
    Set Test Variable    ${arbeidsvermogen}    ${arbeidsvermogen}   
    IF    ${leeftijd} < 21
        Click Element     xpath://bgl-radio[@test-id="inf_rekenhulp1wajong-harmonisatie_step1_question1_${leeftijd}"]/div/div/label
    ELSE
        Click Element     xpath://bgl-radio[@test-id="inf_rekenhulp1wajong-harmonisatie_step1_question1_21"]/div/div/label
    END
    Click Element     xpath://bgl-radio[@test-id="inf_rekenhulp1wajong-harmonisatie_step1_question2_no"]/div/div/label
    IF    "${arbeidsvermogen}" == "wel"
        Click Element    xpath://bgl-radio[@test-id="inf_rekenhulp1wajong-harmonisatie_step1_question3_yes"]/div/div/label
    ELSE IF    "${arbeidsvermogen}" == "geen"
        Click Element    xpath://bgl-radio[@test-id="inf_rekenhulp1wajong-harmonisatie_step1_question3_no"]/div/div/label
    END
    Click Element     css:bgl-button[button-id="inf_rekenhulp1wajong-harmonisatie_step1next"]

# Then

Bedragen zijn correct
    Title Should Be   ${page_title} ${page_title_postfix}
    Page Should Contain    De uitkomst
    ${can_work} =    Evaluate    "${arbeidsvermogen}" == "wel"             
    ${benefit} =     Calculate Benefit    ${age}    ${can_work}
    ${benefit_formatted} =    Format Currency    ${benefit}
    Element Should Contain    xpath://dt[text()="Uw uitkering"]/following-sibling::dd            € ${benefit_formatted} per maand
    Element Should Contain    xpath://dt[text()="Uw bruto-inkomsten"]/following-sibling::dd      € 0,00 per maand
    Element Should Contain    xpath://dt[text()="Totale bruto-inkomen"]/following-sibling::dd    € ${benefit_formatted} per maand
