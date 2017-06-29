:Baran TOPAL 29-09-2009
:GENERIC Static MAC setter batch program for Vista TR

:Gobal Settings which is trivial
:SET TEMP1=TEMP_IP
:SET TEMP2=TEMP_GATEAWAY_IP
:SET TEMP3=TEMP_LOCAL_MAC
:SET TEMP4=TEMP_GATEAWAY_MAC
:SET TEMP5=TEMP_GATEAWAY_IP_MAC

:: Get the current IP address which is trivial
:@IPCONFIG /ALL | FIND /I "IP Adres" > %TEMP1%
:@FOR /F "tokens=1-6 delims=,:. " %%i in (%TEMP1%) do (
:@SET IP=%%k %%l %%m %%n
:)

:: Get the default gateaway address which is trivial
:@IPCONFIG /ALL | FIND /I "Varsayilan Ag Geçidi. . ." > %TEMP2%
:@FOR /F "tokens=1-6 delims=,:. " %%i in (%TEMP2%) do (
:@SET GATEAWAYIP=%%k %%l %%m %%n
:)

:: Get local MAC address which is trivial
:@FOR /F "tokens=3 delims=," %%o in ('"getmac /v /fo csv /nh | findstr Yerel"') do (
:@SET MAC=%%o
:)

:: Get gateaway MAC address of a given gateaway IP but not generic
:@arp -a | FIND /I "xxx.xxx.xxx.xxx" > %TEMP4%
:@FOR /F "tokens=2" %%a IN (%TEMP4%)DO (
:@SET GATEAWAYMAC=%%a
:)

:: Get gateaway MAC and gateaway IP address together and write it to a file but maybe problematic under DC since no right to create file in C drive.
:@arp -a | FIND /I "dinamik" > %TEMP5%

:@FOR /F "tokens=1" %%a IN (%TEMP5%)DO (
:@SET GATEAWAYIP=%%a
:)

:@FOR /F "tokens=2" %%b IN (%TEMP5%)DO (
:@SET GATEAWAYMAC=%%b
:)


:GENERIC SOLUTION
::::::::: Above lines are just for fun, enjoy below. :::::::::
:Even the gateaway IP and MAC are changed, we don't have to be informed

@FOR /F "tokens=1" %%a IN ('arp -a ^| FIND /I "dinamik"')DO (
@SET GATEAWAYIP=%%a
)

@FOR /F "tokens=2" %%b IN ('arp -a ^| FIND /I "dinamik"')DO (
@SET GATEAWAYMAC=%%b
)

:DEBUG MODE
:ECHO Username: %username% 
:ECHO Gateaway MAC Address: %GATEAWAYMAC%
:ECHO Gateaway IP Address: %GATEAWAYIP%
:ECHO PC Name: %Computername%

:Make gateaway ip and mac static
@arp -s %GATEAWAYIP% %GATEAWAYMAC%

EXIT

:END 