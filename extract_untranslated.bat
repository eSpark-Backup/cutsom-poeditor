@echo off
:: Ensure the script stops on errors
setlocal enabledelayedexpansion

:: Find the first .po file in the current directory
for %%f in (*.po) do set POFILENAME=%%f

:: If no .po file is found, exit
if not defined POFILENAME (
    echo No .po file found in the current directory.
    exit /b 1
)

:: Generate untranslated.csv
npx po-csv "!POFILENAME!" > untranslated.csv
if %errorlevel% neq 0 (
    echo Failed to extract untranslated strings. Ensure npx is installed.
    exit /b 1
)

echo Successfully created untranslated.csv for "!POFILENAME!".
