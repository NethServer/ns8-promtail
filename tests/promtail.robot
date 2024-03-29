*** Settings ***
Library    SSHLibrary

*** Test Cases ***
Check if promtail service is loaded correctly
    ${output}  ${rc} =    Execute Command    systemctl show --property=LoadState promtail1.service
    ...    return_rc=True
    Should Be Equal As Integers    ${rc}  0
    Should Be Equal As Strings    ${output}    LoadState=loaded

Check logs for ldapproxy1
    ${output}  ${rc} =    Execute Command  logcli query -q --no-labels '{module_id="ldapproxy1"} | json | line_format "{{.MESSAGE}}"'
    ...    return_rc=True
    Should Be Equal As Integers    ${rc}    0
    Should Not Be Empty    ${output}

Check logs for loki1
    ${output}  ${rc} =    Execute Command  logcli query -q --no-labels '{module_id="loki1"} | json | line_format "{{.MESSAGE}}"'
    ...    return_rc=True
    Should Be Equal As Integers    ${rc}    0
    Should Not Be Empty    ${output}

Check logs for traefik1
    ${output}  ${rc} =    Execute Command  logcli query -q --no-labels '{module_id="traefik1"} | json | SYSLOG_IDENTIFIER="traefik1" | line_format "{{.MESSAGE}}"'
    ...    return_rc=True
    Should Be Equal As Integers    ${rc}    0
    Should Not Be Empty    ${output}

Check logs for promtail1
    ${output}  ${rc} =    Execute Command  logcli query -q --no-labels '{node_id="1"} | json | SYSLOG_IDENTIFIER="promtail1" | line_format "{{.MESSAGE}}"'
    ...    return_rc=True
    Should Be Equal As Integers    ${rc}    0
    Should Not Be Empty    ${output}
