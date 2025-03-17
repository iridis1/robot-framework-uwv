*** Settings ***

Library     SeleniumLibrary
 
*** Variables ***

${selector_uw_uitkering}               xpath://dt[text()="Uw uitkering"]/following-sibling::dd 
${selector_bruto_inkomsten}            xpath://dt[text()="Uw bruto-inkomsten"]/following-sibling::dd 
${selector_totaal_bruto_inkomen}       xpath://dt[text()="Totale bruto-inkomen"]/following-sibling::dd 

*** Keywords ***

Click Start Button
    Click Button    Start

Click Read Button
    Click Link    Lees voor

Select Leeftijd
    [Arguments]    ${leeftijd}
     IF    ${leeftijd} < 21
        Click Answer    question1_${leeftijd}
    ELSE
        Click Answer    question1_21
    END  

Select Inkomen
    [Arguments]    ${wel_of_geen}
    IF    "${wel_of_geen}" == "wel"
        Click Answer    question2_yes
    ELSE
        Click Answer    question2_no
    END    

Select Arbeidsvermogen
    [Arguments]    ${wel_of_geen}
    IF    "${wel_of_geen}" == "wel"
        Click Answer    question3_yes
    ELSE
        Click Answer    question3_no
    END    

Click Answer    
    [Arguments]    ${test_id_postfix}
    Click Element    xpath://bgl-radio[@test-id="inf_rekenhulp1wajong-harmonisatie_step1_${test_id_postfix}"]/div/div/label

Click Next Step Button
    Click Element    css:bgl-button[button-id="inf_rekenhulp1wajong-harmonisatie_step1next"]    
