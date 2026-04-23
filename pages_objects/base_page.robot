*** Settings ***
Library    SeleniumLibrary

Resource    ../variables/variables_globales.robot

 


*** Keywords ***
Se connecter au site
    [Documentation]    Ouvre le site avec navigateur compatible CI

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage

    IF    '${BROWSER}' == 'chrome'
        Open Browser    ${BASE_URL}    chrome    options=${options}
    ELSE IF    '${BROWSER}' == 'firefox'
        Open Browser    ${BASE_URL}    firefox
    ELSE IF    '${BROWSER}' == 'edge'
        Open Browser    ${BASE_URL}    edge
    ELSE
        Fail    Navigateur non supporté : ${BROWSER}
    END

    Maximize Browser Window
    Set Selenium Timeout    ${SELENIUM_TIMEOUT}

Strong
     [Arguments]     ${mot_cle}    @{args}
    [Documentation]    Exécute un mot-clé avec rerejeu automatique en cas d'exception dans la limite d'un nombre de fois en paramètre ci-dessous. 
    ...                Utile pour gérer les erreurs comme StaleElementReferenceException ou autres erreurs intermittentes.
    ${tentatives_max}=    Set Variable    15
    ${attente}=           Set Variable    0.1s

    Attendre Que Le DOM Soit Stable
    # Wait Until Keyword Succeeds    10x    0.2s    Page Should Have Ready State Complete
    FOR    ${index}    IN RANGE    ${tentatives_max}
        TRY
            ${result}=    Run Keyword    ${mot_cle}    @{args}
            Log     Succès à la tentative ${index + 1} pour : ${mot_cle} ${args}
            RETURN    ${result}
        EXCEPT    AS    ${err} 
            Log To Console     Échec tentative ${index + 1} pour : ${mot_cle} ${args}
            Log To Console    Message d'exception : ${err}
            Sleep    ${attente}
        END
    END
    Fail     Échec après ${tentatives_max} tentatives du mot-clé : ${mot_cle} ${args}. Dernière erreur: ${err}

Attendre Que Le DOM Soit Stable
    [Documentation]    Attend que le nombre total d'éléments dans le DOM ne change plus
    ...                entre deux intervalles, indiquant une stabilité structurelle.
    [Arguments]    ${tentatives_max}=10    ${intervalle}=0.2s    ${locator_racine}=xpath=//*
    # Arguments optionnels: tentatives_max, intervalle, locator_racine (pour cibler une partie du DOM si besoin)

    # GCL MODE SILENCIEUX
    # Log To Console    INFO: Attente de la stabilisation du DOM (max ${tentatives_max} tentatives, intervalle ${intervalle})...
    FOR    ${i}    IN RANGE    ${tentatives_max}
        ${compte1}=    Get Element Count    ${locator_racine}
        Sleep    ${intervalle}
        ${compte2}=    Get Element Count    ${locator_racine}

        # Comparaison directe des nombres
        IF    ${compte1} == ${compte2}
            # GCL MODE SILENCIEUX
            # Log To Console    INFO: Le nombre d'éléments (${compte1}) est stable. DOM considéré comme stable.
            RETURN      # Sortir du keyword dès que c'est stable
        # ELSE
            # GCL MODE SILENCIEUX
            # Log To Console    DEBUG: Nombre d'éléments instable à la tentative ${i + 1} (${compte1} vs ${compte2}). Attente de ${intervalle}...
        END
    END
    # Si la boucle se termine sans stabilisation
    Fail    ERREUR: Le nombre d'éléments dans le DOM ne s'est pas stabilisé après ${tentatives_max} tentatives.

Page Should Have Ready State Complete
    ${state}=    Execute Javascript    return document.readyState;
    Should Be Equal    ${state}    complete    L'état de la page n'est pas 'complete' (actuel: ${state})