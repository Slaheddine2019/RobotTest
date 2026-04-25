*** Settings ***
Library    SeleniumLibrary
Resource    ../variables/variables_globales.robot

*** Keywords ***
Se connecter au site
    [Documentation]    Ouvre le site avec navigateur compatible CI

    IF    '${BROWSER}' == 'chrome'
        ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
        Call Method    ${options}    add_argument    --headless
        Call Method    ${options}    add_argument    --no-sandbox
        Call Method    ${options}    add_argument    --disable-dev-shm-usage
        Open Browser    ${BASE_URL}    chrome    options=${options}

    ELSE IF    '${BROWSER}' == 'firefox'
        ${options}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys, selenium.webdriver
        Call Method    ${options}    add_argument    --headless
        Open Browser    ${BASE_URL}    firefox    options=${options}

    ELSE
        Fail    Navigateur non supporté : ${BROWSER}
    END

    Maximize Browser Window
    Set Selenium Timeout    ${SELENIUM_TIMEOUT}