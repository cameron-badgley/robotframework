*** Settings ***
Resource     console_resource.robot

*** Variables ***
${TEST FILE}    ${DATADIR}/misc/pass_and_fail.robot
${STDOUT FILE}  %{TEMPDIR}/redirect_stdout.txt
${STDERR FILE}  %{TEMPDIR}/redirect_stderr.txt

*** Test Cases ***
Invalid Encoding In Environment Variables
    [Tags]  no-windows
    ${stdout}  ${stderr} =  Run Some Tests With Std Streams Redirected
    Should Contain   ${stdout}  Pass And Fail :: Some tests here

*** Keywords ***
Run Some Tests With Std Streams Redirected
  ${cmd} =  Catenate
  ...  echo "redirect stdin" |
  ...  LANG=invalid LC_TYPE=invalid LANGUAGE=invalid LC_ALL=invalid
  ...  ${ROBOT} --consolecolors off ${TESTFILE}
  ...  > ${STDOUT FILE} 2> ${STDERR FILE}
  Run  ${cmd}
  ${stdout} =  Log File  ${STDOUT FILE}
  ${stderr} =  Log File  ${STDERR FILE}
  [Return]  ${stdout}  ${stderr}