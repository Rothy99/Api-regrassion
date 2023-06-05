*** Settings ***
Resource                  ../resources/imports.robot
*** Keywords ***
#Keyword verify for OOB project
Check body response OOB and OTP notification
    [Arguments]     ${resp}
    ${status_code}      Get Value From json     ${resp}     $.code 
    ${smg}      Get Value From json     ${resp}     $.message
    ${status}       Get Value From json     ${resp}     $.data.[0].status       #check status from body response
    ${cause}        Get Value From json     ${resp}     $.data.[*].cause
    # IF  "${status}"=="PROCESSING"
    #     ${cause}=   Evaluate    "\\033[32m${cause}\\033[0m" 
    #     #Convert cause to green color
    # ELSE
    #     ${cause}=   Evaluate    "\\033[31m${cause}\\033[0m"
    #     #Convert cause to red color
    # END
    ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}      S0001
    Should Be Equal As Strings  ${status_code[0]}  S0001   We has found something went wrong!!     ${smg}
    Set Test Message     ${cause[0]}
Check body approve or reject OOB notification
    [Arguments]     ${resp}
    ${status_code}      Get Value From json     ${resp}     $.code 
    ${smg}      Get Value From json     ${resp}     $.message
    IF  "${status_code[0]}"=="ECFM-004"
        # Skip IF     "${smg[0]}"=="Confirmation Failed!"
        # ${smg[0]}=   Evaluate    "\\033[31m${smg[0]}\\033[0m"
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}      ECFM-004
        Should Be Equal As Strings  ${status_code[0]}  ECFM-004   We has found something went wrong!!     ${smg}
    ELSE IF     "${status_code[0]}"=="ECFM-002"
        # Skip IF     "${smg[0]}"=="Your session was expired."
        # ${smg[0]}=   Evaluate    "\\033[31m${smg[0]}\\033[0m"
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}      ECFM-002
        Should Be Equal As Strings  ${status_code[0]}  ECFM-002   We has found something went wrong!!     ${smg}
    ELSE IF     "${status_code[0]}"=="ECFM-001"   #Check if device no ativate account
         ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}      ECFM-001
        Should Be Equal As Strings  ${status_code[0]}  ECFM-001   We has found something went wrong!!     ${smg}
    ELSE IF     "${status_code[0]}"=="EF0001"   #Check if device no ativate account
         ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}      EF0001
        Should Be Equal As Strings  ${status_code[0]}  EF0001   We has found something went wrong!!     ${smg}
    ELSE IF     "${status_code[0]}"=="E0001"   #Check if device no ativate account
         ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}      E0001
        Should Be Equal As Strings  ${status_code[0]}  E0001   We has found something went wrong!!     ${smg}
    ELSE 
        # Skip IF     "${smg[0]}"=="Confirmation Failed!"
        # ${smg[0]}=   Evaluate    "\\033[31m${smg[0]}\\033[0m"
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}      S0001
        Should Be Equal As Strings  ${status_code[0]}  S0001   We has found something went wrong!!     ${smg}
    END
    Set Test Message         ${smg[0]}
Check OOB inquiry response body
    [Arguments]     ${resp}
    ${status_code}      Get Value From json     ${resp}     $.code 
    ${smg}      Get Value From json     ${resp}     $.message
    IF  "${status_code[0]}"=="ECFM-001"
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}      ECFM-001
        Should Be Equal As Strings  ${status_code[0]}  ECFM-001   We has found something went wrong!!     ${smg}
    ELSE
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}      S0001
        Should Be Equal As Strings  ${status_code[0]}  S0001   We has found something went wrong!!     ${smg}
    END
    Set Test Message         ${smg[0]}

#Keyword Verify for online account opening
check get response body for verify phone number
    [Arguments]     ${resp}
    ${status_code}      Get value from json     ${resp}     $.code
    ${smg}      Get value from json     ${resp}     $.message
    IF   "${status_code[0]}"=="EAO-P001"
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       EAO-P001
        Should Be Equal As Strings  ${status_code[0]}   EAO-P001    We has found somthing went wrong!!  ${smg}
    ELSE 
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       S0001
        Should Be Equal As Strings  ${status_code[0]}   S0001       We has found somthing went wrong!!  ${smg}
    END
    set Test Message        ${smg[0]}

check get response body for verify OTP
    [Arguments]     ${resp}
    ${status_code}      Get value from json     ${resp}     $.code
    ${smg}      Get value from json     ${resp}     $.message
    IF   "${status_code[0]}"=="UP-IN003"
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       UP-IN003
        Should Be Equal As Strings  ${status_code[0]}   UP-IN003    We has found somthing went wrong!!  ${smg}
    ELSE IF   "${status_code[0]}"=="E0001"
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       E0001
        Should Be Equal As Strings  ${status_code[0]}   E0001    We has found somthing went wrong!!  ${smg}
    ELSE IF   "${status_code[0]}"=="EREQID-03"
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       EREQID-03
        Should Be Equal As Strings  ${status_code[0]}   EREQID-03    We has found somthing went wrong!!  ${smg}
    ELSE IF   "${status_code[0]}"=="UP-EP001"
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       UP-EP001
        Should Be Equal As Strings  ${status_code[0]}   UP-EP001    We has found somthing went wrong!!  ${smg}
    ELSE IF   "${status_code[0]}"=="EREQID-01"
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       EREQID-01
        Should Be Equal As Strings  ${status_code[0]}   EREQID-01    We has found somthing went wrong!!  ${smg}
    ELSE IF   "${status_code[0]}"=="EREQID-02"
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       EREQID-02
        Should Be Equal As Strings  ${status_code[0]}   EREQID-02    We has found somthing went wrong!!  ${smg}
    ELSE IF   "${status_code[0]}"=="EF0001"         #check if NID null or user image null
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       EF0001
        Should Be Equal As Strings  ${status_code[0]}   EF0001    We has found somthing went wrong!!  ${smg}
    ELSE IF   "${status_code[0]}"=="HTTP400"         #check if not feild verify_id 
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       HTTP400
        Should Be Equal As Strings  ${status_code[0]}   HTTP400    We has found somthing went wrong!!  ${smg}
    ELSE IF   "${status_code[0]}"=="EREQID-05"         #check if verify_id null
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       EREQID-05
        Should Be Equal As Strings  ${status_code[0]}   EREQID-05    We has found somthing went wrong!!  ${smg}
    ELSE IF   "${status_code[0]}"=="EAO-P006"         #check if kyc exit
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       EAO-P006
        Should Be Equal As Strings  ${status_code[0]}   EAO-P006    We has found somthing went wrong!!  ${smg}
     ELSE IF   "${status_code[0]}"=="EAO-P005"         #check if kyc invalid information
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       EAO-P005
        Should Be Equal As Strings  ${status_code[0]}   EAO-P005    We has found somthing went wrong!!  ${smg}
    ELSE 
        ${response_status}=  Run keyword and return status   Should Be Equal As Strings      ${status_code[0]}       S0001
        Should Be Equal As Strings  ${status_code[0]}   S0001       We has found somthing went wrong!!  ${smg}
    END
    set Test Message        ${smg[0]}    