echo off
set OLDDIR=%CD%

echo �믮���� ��ࢨ筮� ᪠稢���� ���㫥�
cd %OLDDIR% && git submodule update --init --recursive

echo �믮���� ��� ��������� ���㫥�
cd %OLDDIR%\tools\cikulix && git reset --hard HEAD
cd %OLDDIR%\tools\vanessa-behavior && git reset --hard HEAD
cd %OLDDIR%\tools\xUnitFor1C && git reset --hard HEAD
cd %OLDDIR%\features\bit_libs && git reset --hard HEAD

echo �믮���� ���筮� ᪠稢���� ���㫥�
cd %OLDDIR% && git submodule update --init --recursive
