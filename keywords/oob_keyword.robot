*** Keywords ***
Resource            ../resources/imports.robot
*** Keywords ***

Set Push OTP notification
    ${external_reference}=     Generate Random String    32    [LETTERS][NUMBERS]   
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${json}    Catenate
    ...    {
    ...	 "service_id": "online_pay_otp",
    ...	 "batch_id": "0001",
    ...	 "body": [
    ...		{
    ...			"external_reference": "${external_reference}",
    ...			"cif": "${cif}",
    ...			"data": {
    ...				"currency": "KHR",
    ...				"amount": "50",
    ...				"otp_code": "123456",
    ...				"merchant_name": "Rothyyyyy Rothy yyyy Roth yyyyy",
    ...				"card_mask": "1234 12** **59 1234"
    ...			}
    ...		}
    ...	 ]
    ...  }
    log     ${json}
    Create Session  Pushnotification    ${baseurl}   

    ${response}=    POST On Session    Pushnotification    ${sendotp}    data=${json}    headers=${headers}
    log     ${response}
    [Return]    ${response}
    Check body response OOB and OTP notification      ${response.json()}

Set Push OOB notification
    Create Session  Pushnotification    ${baseurl}  
    ${external_reference}=     Generate Random String    32    [LETTERS][NUMBERS]   
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${json}    Catenate
    ...    {
    ...	 "service_id": "online_pay_consent",
    ...	 "batch_id": "3238",
    ...	 "body": [
    ...		{
    ...			"external_reference": "${external_reference}",
    ...			"cif": "${cif}",
    ...			"data": {
    ...				"currency": "USD",
    ...				"amount": "50",
    ...				"merchant_name": "Rothyyyyy Rothy yyyy Roth yyyyy",
    ...				"card_mask": "1234 12** **59 1234"
    ...			}
    ...		}
    ...	 ]
    ...  }
    log     ${json}
    ${response}=    POST On Session    Pushnotification    ${sendoob}    data=${json}    headers=${headers}
    log     ${response}
    [Return]    ${response}
    Check body response OOB and OTP notification      ${response.json()}
    ${Get_external_referenc}=       Get Value from json     ${response.json()}       $.data.[0].external_reference
    log     ${Get_external_referenc}
    Set Suite Variable      ${Get_external_referenc}
Get OOB notification by external rerference
    [Arguments]     ${external_key}
    Create Session      inquiry_data    ${baseurl}     verify=true   
    ${header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${Response}=   Get on Session   inquiry_data     ${inquiry_oob}/${external_key[0]}        headers=${header}        expected_status=anything
    [Return]        ${Response}
    Check OOB inquiry response body     ${Response.json()}
Get OOB notification has expired
    Create Session      inquiry_data    ${baseurl}     verify=true   
    ${header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${Response}=   Get on Session   inquiry_data     ${inquiry_oob}/k67224d947ec4f8c963090f3b912cda2        headers=${header}        expected_status=anything
    [Return]        ${Response}
    Check OOB inquiry response body     ${Response.json()}

Get OOB notification has failed
    Create Session      inquiry_data    ${baseurl}     verify=true   
    ${header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${Response}=   Get on Session   inquiry_data     ${inquiry_oob}/k67224d947ec4f8c963090f3b912cda8        headers=${header}        expected_status=anything
    [Return]        ${Response}
    Check OOB inquiry response body     ${Response.json()}
Approve OOB notification
    [Arguments]     ${external_key}
    Create Session  oob_approve     ${baseurl}      verify=true
    ${header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${json}     Catenate
    ...     {
    ...     "ext_ref": "${external_key[0]}"
    ...     }

    ${Response}=    POST On Session      oob_approve     ${approve_oob}      data=${json}        headers=${header}      expected_status=anything
    [Return]        ${Response}
    Check body approve or reject OOB notification      ${Response.json()}   
Reject expired OOB notification
    [Arguments]     ${external_key}
    Create Session  oob_reject     ${baseurl}      verify=true
    ${header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${json}     Catenate
    ...     {
    ...     "ext_ref": "${external_key[0]}"
    ...     }

    ${Response}=    POST On Session      oob_reject     ${reject_oob}      data=${json}        headers=${header}      expected_status=anything
    [Return]        ${Response}
    Check body approve or reject OOB notification      ${Response.json()} 
Approve expried OOB notification
    Create Session  oob_reject     ${baseurl}      verify=true
    ${header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${json}     Catenate
    ...     {
    ...     "ext_ref": "k67224d947ec4f8c963090f3b912cda3"
    ...     }

    ${Response}=    POST On Session      oob_reject     ${reject_oob}      data=${json}        headers=${header}      expected_status=anything
    [Return]        ${Response}
    Check body approve or reject OOB notification      ${Response.json()} 
Reject OOB notification
    Create Session  Pushnotification    ${baseurl}  
    ${external_reference}=     Generate Random String    32    [LETTERS][NUMBERS]   
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${json}    Catenate
    ...    {
    ...	 "service_id": "online_pay_consent",
    ...	 "batch_id": "3238",
    ...	 "body": [
    ...		{
    ...			"external_reference": "${external_reference}",
    ...			"cif": "${cif}",
    ...			"data": {
    ...				"currency": "USD",
    ...				"amount": "50",
    ...				"merchant_name": "Rothyyyyy Rothy yyyy Roth yyyyy",
    ...				"card_mask": "1234 12** **59 1234"
    ...			}
    ...		}
    ...	 ]
    ...  }
    log     ${json}
    ${response}=    POST On Session    Pushnotification    ${sendoob}    data=${json}    headers=${headers}
    log     ${response}
    [Return]    ${response}
    Check body response OOB and OTP notification      ${response.json()}
    ${Get_external_referenc}=       Get Value from json     ${response.json()}       $.data.[0].external_reference
    log     ${Get_external_referenc}
    Set Suite Variable      ${Get_external_referenc}
    Create Session  oob_reject     ${baseurl}      verify=true
    ${jsonbody}     Catenate
    ...     {
    ...     "ext_ref": "${Get_external_referenc[0]}"
    ...     }
    ${Response}=    POST On Session      oob_reject     ${approve_oob}      data=${jsonbody}        headers=${headers}      expected_status=anything
    Check body approve or reject OOB notification      ${Response.json()}  

Push OTP notification existing external reference
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${json}    Catenate
    ...    {
    ...	 "service_id": "online_pay_otp",
    ...	 "batch_id": "0001",
    ...	 "body": [
    ...		{
    ...			"external_reference": "c67224d947ec4f8c963890f3b912cdt9",
    ...			"cif": "${cif}",
    ...			"data": {
    ...				"currency": "KHR",
    ...				"amount": "50",
    ...				"otp_code": "123456",
    ...				"merchant_name": "Rothyyyyy Rothy yyyy Roth yyyyy",
    ...				"card_mask": "1234 12** **59 1234"
    ...			}
    ...		}
    ...	 ]
    ...  }
    log     ${json}
    Create Session  Pushnotification    ${baseurl}   

    ${response}=    POST On Session    Pushnotification    ${sendotp}    data=${json}    headers=${headers}
    log     ${response}
    [Return]    ${response}
    Check body response OOB and OTP notification      ${response.json()}
Push OOB notification existing external reference
    Create Session  Pushnotification    ${baseurl}    
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${json}    Catenate
    ...    {
    ...	 "service_id": "online_pay_consent",
    ...	 "batch_id": "3238",
    ...	 "body": [
    ...		{
    ...			"external_reference": "c67224d947ec4f8c963090f3b912cdc9",
    ...			"cif": "${cif}",
    ...			"data": {
    ...				"currency": "KHR",
    ...				"amount": "50",
    ...				"otp_code": "123456",
    ...				"merchant_name": "Rothyyyyy Rothy yyyy Roth yyyyy",
    ...				"card_mask": "1234 12** **59 1234"
    ...			}
    ...		}
    ...	 ]
    ...  }
    log     ${json}

    ${response}=    POST On Session    Pushnotification    ${sendotp}    data=${json}    headers=${headers}
    log     ${response}
    [Return]    ${response}
    Check body response OOB and OTP notification      ${response.json()}
Approve OOB notification without external reference
    Create Session  oob_approve     ${baseurl}      verify=true
    ${header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${json}     Catenate
    ...     {
    ...     "ext_ref": ""
    ...     }

    ${Response}=    POST On Session      oob_approve     ${approve_oob}      data=${json}        headers=${header}      expected_status=anything
    [Return]        ${Response}
    Check body approve or reject OOB notification      ${Response.json()} 
Approve OOB notification without request body
    Create Session  oob_approve     ${baseurl}      verify=true
    ${header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${json}     Catenate
    ...     {
    ...     "ext_ref": ""
    ...     }
    ${Response}=    POST On Session      oob_approve     ${approve_oob}     data=""       headers=${header}     expected_status=anything     
    [Return]        ${Response}
    Check body approve or reject OOB notification      ${Response.json()} 
Reject OOB notification without external reference

    Create Session  oob_reject     ${baseurl}      verify=true
    ${header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${json}     Catenate
    ...     {
    ...     "ext_ref": ""
    ...     }

    ${Response}=    POST On Session      oob_reject     ${reject_oob}      data=${json}        headers=${header}      expected_status=anything
    [Return]        ${Response}
    Check body approve or reject OOB notification      ${Response.json()} 
Reject OOB notification without request body

    Create Session  oob_reject     ${baseurl}      verify=true
    ${header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${json}     Catenate
    ...     {
    ...     "ext_ref": ""
    ...     }
    ${Response}=    POST On Session      oob_reject     ${reject_oob}      data=""        headers=${header}      expected_status=anything
    [Return]        ${Response}
    Check body approve or reject OOB notification      ${Response.json()}
Inquiry OOB notification incorrect external reference
    Create Session      inquiry_data    ${baseurl}     verify=true   
    ${header}=    Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ${Response}=   Get on Session   inquiry_data     ${inquiry_oob}/k67224d947ec4f8c963090f3b912cda8k        headers=${header}        expected_status=anything
    [Return]        ${Response}
    Check OOB inquiry response body     ${Response.json()}
Generate Number
    ${SEQUENCE_NUMBER}=  Evaluate  ${SEQUENCE_NUMBER} + 1
    Set Suite Variable   ${SEQUENCE_NUMBER}