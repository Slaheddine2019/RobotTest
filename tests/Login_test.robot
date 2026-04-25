*** Settings ***
Library    SeleniumLibrary
Resource    ../pages_objects/login_page.robot

*** Variables ***
${Valid_Username}      standard_user
${Valid_Password}      secret_sauce
${Invalid_Username}    12
${Invalid_Password}    244

*** Test Cases ***

Login avec valid credentials
    [Documentation]    Connexion avec identifiants valides
    [Tags]    login
    [Setup]    Se connecter au site
    [Teardown]    Close All Browsers

    Saisir username    ${Valid_Username}
    saisir password   ${Valid_Password}
    Cliquer sur le bouton Login
    Verifier affichage page Produits
    Capture Page Screenshot


Login avec invalid credentials
    [Documentation]    Vérifie qu’un login invalide échoue
    [Tags]    login
    [Setup]    Se connecter au site
    [Teardown]    Close All Browsers

    Saisir username    ${Invalid_Username}
    saisir password   ${Invalid_Password}
    Cliquer sur le bouton Login

    # Vérification plus fiable
    Page Should Contain Element    xpath=//h3[contains(text(),'Epic sadface')]

    Capture Page Screenshot