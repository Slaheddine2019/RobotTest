*** Settings ***
Library    SeleniumLibrary

Resource    ../variables/variables_globales.robot
Resource    ../pages_objects/base_page.robot

*** Variables ***
${Username_Field}     xpath=//input[@id='user-name']
${Password_Field}     xpath=//input[@id='password']
${Btn_Login}          xpath=//input[@id='login-button']
${Title_Produits}     xpath=//span[@class='title' and contains(text(),'Products')]

*** Keywords ***

Saisir username
    [Arguments]    ${username}
    Wait Until Element Is Visible    ${Username_Field}    timeout=10s
    Input Text    ${Username_Field}    ${username}

saisir password
    [Arguments]    ${password}
    Wait Until Element Is Visible    ${Password_Field}    timeout=10s
    Input Text    ${Password_Field}    ${password}

Cliquer sur le bouton Login
    Wait Until Element Is Visible    ${Btn_Login}    timeout=10s
    Click Button    ${Btn_Login}

Verifier affichage page Produits
    Wait Until Element Is Visible    ${Title_Produits}    timeout=10s
    Element Should Contain    ${Title_Produits}    Products