echo off
set OLDDIR=%CD%

echo Выполняю первичное скачивание модулей
cd %OLDDIR% && git submodule update --init --recursive

echo Выполняю сброс изменений модулей
cd %OLDDIR%\tools\cikulix && git reset --hard HEAD
cd %OLDDIR%\tools\vanessa-behavior && git reset --hard HEAD
cd %OLDDIR%\tools\xUnitFor1C && git reset --hard HEAD
cd %OLDDIR%\features\bit_libs && git reset --hard HEAD

echo Выполняю вторичное скачивание модулей
cd %OLDDIR% && git submodule update --init --recursive
