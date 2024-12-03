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

:: Ensure untranslated.csv exists
if not exist untranslated.csv (
    echo untranslated.csv not found in the current directory.
    exit /b 1
)

:: Apply the translations
npx po-csv "!POFILENAME!" untranslated.csv > translated.po
if %errorlevel% neq 0 (
    echo Failed to apply translations. Ensure npx is installed.
    exit /b 1
)

:: Replace the original .po file with the translated one
move /Y translated.po "!POFILENAME!"
if %errorlevel% neq 0 (
    echo Failed to replace the original .po file.
    exit /b 1
)

echo Successfully applied translations to "!POFILENAME!".
