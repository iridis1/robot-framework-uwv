*** Settings ***

Library     SeleniumLibrary
Resource    ../lib/common_keywords.resource
 
*** Variables ***
${start_button}      css:.oxd-alert-content--error
 
*** Keywords ***

Click Start Button
    Click Button    Start