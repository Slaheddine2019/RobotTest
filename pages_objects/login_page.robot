*** Settings ***
Library    SeleniumLibrary

Resource    ../variables/variables_globales.robot   
Resource    ../pages_objects/base_page.robot
*** Variables ***


${BTN_BONJOUR_IDENTIFIEZ_VOUS}    xpath=//span[@class='nav-action-inner']
${Btn_aacept_popup_page_acceuil}    xpath=//input[@id='sp-cc-accept']
${Username_Field}     xpath=//input[@id='user-name'] 
${Passeword_Field}    xpath=//input[@id='password']
${Btn_Login}    xpath=//input[@id='login-button']


*** Keywords ***

Saisir username 
    [Arguments]    ${username}
    Strong    Wait Until Element Is Visible    ${Username_Field}
    Input Text    ${Username_Field}     ${username}
Saisir mode de passe
      [Arguments]    ${passeword}
    Strong    Wait Until Element Is Visible    ${Passeword_Field}
    Input Text    ${Passeword_Field}     ${passeword}
Cliquer sur le bouton Login
    Strong    Wait Until Element Is Visible    ${Btn_Login}
    Strong    Click Button    ${Btn_Login}


verifier l'affichage de titre Produits

    Strong    Page Should Contain    Swag Labs

