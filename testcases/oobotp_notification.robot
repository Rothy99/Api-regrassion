*** Settings ***
Resource            ../resources/imports.robot
Resource            ../keywords/oob_keyword.robot

*** Test Cases ***
 1
Check Push OTP notification
    [Tags]      positive
    Set Push OTP notification
Check Push OOB notification
    [Tags]      positive
    Set Push OOB notification
Check Inquiry OOB notification by external reference
    [Tags]      positive
    Get OOB notification by external rerference     ${Get_external_referenc}
Check Inquiry OOB notification has expired    #static external_reference
    [Tags]      positive
    Get OOB notification has expired
Check Inquiry OOB nofication has failed      # #static external_reference
    [Tags]      positive
    Get OOB notification has failed
Check approve OOB notification
    [Tags]      positive
    Approve OOB notification  ${Get_external_referenc}
Check reject OOB notification       #Push OOB notification then reject
    [Tags]      positive
    Reject OOB notification
Check reject expired OOB notification
    [Tags]      positive
    Reject expired OOB notification  ${Get_external_referenc}
Check approve expired OOB notification
    [Tags]      positive
    Approve expried OOB notification
Check push OTP notification existing external reference
    [Tags]      Negative
    Push OTP notification existing external reference
Check push OOB notification existing external reference
    [Tags]      Negative
    Push OOB notification existing external reference
Check approve OOB notification without external reference
    [Tags]      Negative
    Approve OOB notification without external reference
Check approve OOB notification without request body
    [Tags]      Negative
    Approve OOB notification without request body
Check reject OOB notification without external reference
    [Tags]      Negative
    Reject OOB notification without external reference
Check reject OOB notification with request body
    [Tags]      Negative
    Reject OOB notification without request body
Check Inquiry OOB notification incorrect external reference
    [Tags]      Negative
    Inquiry OOB notification incorrect external reference
