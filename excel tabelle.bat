@echo off
setlocal enabledelayedexpansion

rem Variablen
set inputFile=%userprofile%\Desktop\result.txt
set outputFile=%userprofile%\Desktop\result.csv

rem CSV-Header schreiben
echo Schuljahr,Fach,Klasse,Anzahl der Klassenarbeiten > %outputFile%

rem Leere Variablen zum Speichern von Ergebnissen
set Schuljahr=
set Fach=
set Klasse=
set AnzahlKlassenarbeiten=0

rem HashMap für die Ergebnisse
for /F "delims=" %%A in ('type "%inputFile%"') do (
    rem Überprüfen, ob es sich um eine Datei handelt und nicht die letzte Zeile mit der Anzahl der Dateien
    if not "%%A"=="7  Files Found" (
        rem Extrahieren der Klasse und des Schuljahrs
        for /F "tokens=5,6 delims=\" %%B in ("%%A") do (
            set "Schuljahr=%%~nB"
            set "Klasse=%%~nC"
            
            rem Inkrementiere Anzahl der Klassenarbeiten für diese Klasse und dieses Schuljahr
            set /A AnzahlKlassenarbeiten[!Schuljahr!-!Klasse!]+=1
        )
    )
)

rem Ergebnisse in CSV schreiben
for /F "tokens=1,2 delims==" %%A in ('set AnzahlKlassenarbeiten[') do (
    set "key=%%~A"
    set "value=%%~B"
    for /F "tokens=1,2 delims=-" %%B in ("!key!") do (
        echo %%B,Deutsch,%%C,!value! >> %outputFile%
    )
)

rem CSV-Datei in Excel öffnen
start excel "%outputFile%"

endlocal
