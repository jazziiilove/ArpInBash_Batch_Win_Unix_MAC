:Baran TOPAL 29-09-2009
:GENERIC Static MAC setter batch program for XP EN


:Gobal Settings which is trivial
:SET TEMP1=TEMP_IP
:SET TEMP2=TEMP_GATEAWAY_IP
:SET TEMP3=TEMP_LOCAL_MAC
:SET TEMP4=TEMP_GATEAWAY_MAC
:SET TEMP5=TEMP_GATEAWAY_IP_MAC

:: Get the current IP address which is trivial
:@IPCONFIG /ALL | FIND /I "IP Address" > %TEMP1%
:@FOR /F "tokens=1-6 delims=,:. " %%i in (%TEMP1%) do (
:@SET IP=%%k %%l %%m %%n
:)


:: Get the default gateaway address which is trivial
:@IPCONFIG /ALL | FIND /I "Default Gateway. . ." > %TEMP2%
:@FOR /F "tokens=1-6 delims=,:. " %%i in (%TEMP2%) do (
:@SET GATEAWAYIP=%%k %%l %%m %%n
:)


:: Get local MAC address which is trivial
:@IPCONFIG /ALL | FIND /I "Physical Address" > %TEMP3%
:@SET LOCALMAC=%%q

:: Get gateaway MAC address of a given gateaway IP but not generic
:@arp -a | FIND /I "xxx.xxx.xxx.xxx" > %TEMP4%
:@FOR /F "tokens=2" %%a IN (%TEMP4%)DO (
:@SET GATEAWAYMAC=%%a
:)

:: Get gateaway MAC and gateaway IP address together and write it to a file but maybe problematic under DC since no right to create file in C drive.
:@arp -a | FIND /I "dynamic" > %TEMP5%

:@FOR /F "tokens=1" %%a IN (%TEMP5%)DO (
:@SET GATEAWAYIP=%%a
:)

:@FOR /F "tokens=2" %%b IN (%TEMP5%)DO (
:@SET GATEAWAYMAC=%%b
:)

:GENERIC SOLUTION
::::::::: Above lines are just for fun, enjoy below. :::::::::
:Even the gateaway IP and MAC are changed, we don't have to be informed

@FOR /F "tokens=1" %%a IN ('arp -a ^| FIND /I "dynamic"')DO (
@SET GATEAWAYIP=%%a
)

@FOR /F "tokens=2" %%b IN ('arp -a ^| FIND /I "dynamic"')DO (
@SET GATEAWAYMAC=%%b
)

:APR poisoning check
:Make gateaway ip and mac static
if %GATEAWAYIP% == 139.179.33.1 (
if %GATEAWAYMAC% == 00-15-f2-64-a3-38 (
echo "no problem"
@arp -s %GATEAWAYIP% %GATEAWAYMAC%
)
)

if not %GATEAWAYIP% == 139.179.33.1 (
if not %GATEAWAYMAC% == 00-15-f2-64-a3-38 (
@SET GATEAWAYIP = 139.179.33.1
@SET GATEAWAYMAC = 00-15-f2-64-a3-38
@arp -d
@arp -s %GATEAWAYIP% %GATEAWAYMAC%
)
)

:DEBUG MODE
ECHO Username: %username% 
ECHO Gateaway MAC Address: %GATEAWAYMAC%
ECHO Gateaway IP Address: %GATEAWAYIP%
ECHO PC Name: %Computername%

EXIT

:END 