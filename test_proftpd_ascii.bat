@echo off
setlocal enabledelayedexpansion

chcp 65001

set "text= Сидельников Артем Максимович, 04.06.2003, город: Санкт-Петербург, профессия:Веб-разработчик"


(for /L %%i in (1, 1, 100000) do (  
echo !text! 
)) >> w_result.txt

chcp 20866


(for /L %%i in (1, 1, 100000) do (  
echo !text! 
)) >> w_result.txt

chcp 1251

(for /L %%i in (1, 1, 100000) do (  echo !text! )) >> w_result.txt

chcp 866

(for /L %%i in (1, 1, 100000) do (  echo !text! )) >> w_result.txt