@echo off
robot -d results_chrome -v BROWSER:chrome tests/
robot -d results_edge -v BROWSER:edge tests/
robot -d results_firefox -v BROWSER:firefox tests/