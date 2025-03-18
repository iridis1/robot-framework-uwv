*** Settings ***

Library    SeleniumLibrary
Library    ../util/common_keywords.resource
 
*** Variables ***

${search_input}    id:hom_vhead_input_1
${logo}            css:div.bgl-header-brand"

*** Keywords ***

Search    
    [Arguments]    ${search_text}
    Input Text     ${search_input}    ${search_text}
    Press Keys     None    ENTER
    Wait Until Page Loaded
    Sleep          1    # Somehow links cannot always be interacted with
    
 Login    
    [Arguments]    ${user}    ${password}
    Click Button    Inloggen
    # Implement when required