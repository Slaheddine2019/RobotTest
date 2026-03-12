*** Settings ***
Library    SeleniumLibrary

Resource    ../pages_objects/login_page.robot

*** Variables ***

${Valid_Username}    standard_user
${Valid_Password}  secret_sauce
${Invalid_Username}    12
${Invalid_Password}  244



*** Test Cases ***


Login avec valid cridentiels
    [Documentation]    ce cas de test permet de se connecter au site avec
    ...  un username et mot de passe valides
    [Tags]    login
    [Setup]    Se connecter au site   
    [Teardown]    Fermer tout les navigateurs 
   Saisir username    ${Valid_Username} 
   Saisir mode de passe    ${Valid_Password}
   Cliquer sur le bouton Login
   verifier l'affichage de titre Produits
   Capture Page Screenshot

 Login avec invalid cridentiels 

   [Documentation]    ce cas de test permet de vérifier qu'on ne peut pas se connecter au site par
    ...  un username et mot de passe invalides 
    [Tags]    login
    [Setup]    Se connecter au site    
    [Teardown]    Fermer tout les navigateurs 
   Saisir username    ${Invalid_Username} 
   Saisir mode de passe    ${Invalid_Password}
   Cliquer sur le bouton Login
   Strong     Page Should Not Contain    Produits
   Capture Page Screenshot
    