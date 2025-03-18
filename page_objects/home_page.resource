*** Settings ***

Library    SeleniumLibrary
 
*** Variables ***

${search_input}    id:hom_vhead_input_1
${logo}            css:div.bgl-header-brand

*** Keywords ***

Search    
    [Arguments]    ${search_text}
    Input Text     ${search_input}    ${search_text}
    Press Keys     None    ENTER
    Wait Until Element Contains    tag:h1    resultaten voor ${search_text}   
    Sleep          2    # Somehow links can only be interacted with after a second or two
    
 Login    
    [Arguments]    ${user}    ${password}
    Click Button    Inloggen
    # Implement when required