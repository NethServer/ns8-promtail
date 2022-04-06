*** Settings ***
Library    SSHLibrary

*** Test Cases ***
Check if promtail service is loaded correctly
    ${output}  ${rc} =    Execute Command    systemctl show --property=LoadState promtail1.service
    ...    return_rc=True
    Should Be Equal As Integers    ${rc}  0
    Should Be Equal As Strings    ${output}    LoadState=loaded
