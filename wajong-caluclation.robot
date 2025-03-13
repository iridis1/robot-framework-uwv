*** Settings ***

Documentation   Basic company website validation
Metadata        Wajong 2025 

Library        SeleniumLibrary

*** Variables ***
${BASE_URL}    FromConfig

*** Test Cases ***

Verify company home page
    Open Browser    ${BASE_URL} 



