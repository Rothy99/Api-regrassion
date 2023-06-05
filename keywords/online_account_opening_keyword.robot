*** Settings ***
Resource                  ../resources/imports.robot
*** Keywords ***
verify phone number 
    Create Session      verify_session      ${baseurl}      
    ${phone_number}=     Generate Random String    9    [NUMBERS]
    Log     ${phone_number}
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ...    client_req_timestamp=${client_req_timestamp}
    ...    channel=CUSTOMER_MOBILE
    ${Response}=   Get on Session     verify_session      ${verify_phonenumber}${phone_number}        headers=${headers}    expected_status=anything
    Log     ${Response}
    [Return]        ${Response}
    check get response body for verify phone number     ${Response.json()}
    ${verify_id}=   Get value from json     ${Response.json()}     $.data.verify_id
    
    Log     ${verify_id}
    Set Suite Variable      ${verify_id}
    Set Suite Variable      ${phone_number}
Verify phone number existing
    Create Session      verify_session      ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ...    client_req_timestamp=${client_req_timestamp}
    ...    channel=CUSTOMER_MOBILE
    ${Response}=   Get on Session     verify_session      ${verify_phonenumber}12608611        headers=${headers}    expected_status=anything
    Log     ${Response}
    [Return]        ${Response}
    check get response body for verify phone number     ${Response.json()}
Check verify OTP
    [Arguments]     ${verify_id}    ${phone_number}
    Create Session      baseUrl     ${baseurl}
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "otp_type": "ACCOUNT_OPENING",
    ...     "otp": "g9zs6r6sj7bwW5pxC7SMyAMh4VTNzA9FvhAt4qh6hQI38Nboi+o8itVD4jwupJtuCiIkje9GDfHCIJCl83DVIwpHEj6zd7N2y6X3mO2qOO2WrrnZhqeKL3uvrBOoV/4e1+NFQQH8Tr7XRzxT6pgXf6o/AY2Kqraas38j6xDf3efJ50/GFZea1py3rGPMuGdLvfamiCT5ZJenzgDkIxfAqFRgwZi3/jKX61jncAZMXr/SOTllKQBHGfiRWDBHBxvvWiW7ilHLusqF19r+QuFSA6Luc/lgzSrLFyAVXfVKERfVwDSh6FyMvjuzaqoPKT+tue1CaNxC42fbfNBtM/cDfXPuKqBLGGnY5ADUswIO9GyvMsrEzZar2i1sVQ1FsAExIhr8KA2suMPdq9KL5a1LxZHiBc5/UeBkfskIZ3g5QPrE4NnxShSkQiLNabJf828wJaC3BvWimMfutXso4aVUaLf0xq+jGplnqQujR9ZppR0GLgdrDOojEnVXJDFckbFVEXIyELBhjTSV3D6wuzqJ8DuCkyWN/7nRHCl/sVhsEMdas+NgCXuW5P2nv69RAWAvLeTCIJpfDnmYtDpE1sVOG5Br+KVum/F3rWazoW4XsHOMOaDKWyG1YRHX9Q3NmIal37hSvYxxv75TgJfrX7FFTYO+w9ojlKeSWq8uutqDTgU="
    ...     }
    ${Response}=    POST On Session     baseUrl     ${otp_online_acc_opening}       data=${json}        headers=${headers}
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Check verify OTP incorrect
    [Arguments]     ${verify_id}    ${phone_number}
    Create Session      baseUrl     ${baseurl}
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "otp_type": "ACCOUNT_OPENING",
    ...     "otp": "tg9zs6r6sj7bwW5pxC7SMyAMh4VTNzA9FvhAt4qh6hQI38Nboi+o8itVD4jwupJtuCiIkje9GDfHCIJCl83DVIwpHEj6zd7N2y6X3mO2qOO2WrrnZhqeKL3uvrBOoV/4e1+NFQQH8Tr7XRzxT6pgXf6o/AY2Kqraas38j6xDf3efJ50/GFZea1py3rGPMuGdLvfamiCT5ZJenzgDkIxfAqFRgwZi3/jKX61jncAZMXr/SOTllKQBHGfiRWDBHBxvvWiW7ilHLusqF19r+QuFSA6Luc/lgzSrLFyAVXfVKERfVwDSh6FyMvjuzaqoPKT+tue1CaNxC42fbfNBtM/cDfXPuKqBLGGnY5ADUswIO9GyvMsrEzZar2i1sVQ1FsAExIhr8KA2suMPdq9KL5a1LxZHiBc5/UeBkfskIZ3g5QPrE4NnxShSkQiLNabJf828wJaC3BvWimMfutXso4aVUaLf0xq+jGplnqQujR9ZppR0GLgdrDOojEnVXJDFckbFVEXIyELBhjTSV3D6wuzqJ8DuCkyWN/7nRHCl/sVhsEMdas+NgCXuW5P2nv69RAWAvLeTCIJpfDnmYtDpE1sVOG5Br+KVum/F3rWazoW4XsHOMOaDKWyG1YRHX9Q3NmIal37hSvYxxv75TgJfrX7FFTYO+w9ojlKeSWq8uutqDTgU="
    ...     }
    ${Response}=    POST On Session     baseUrl     ${otp_online_acc_opening}       data=${json}        headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Check verify incorrect OTP type
    [Arguments]     ${verify_id}    ${phone_number}
    Create Session      baseUrl     ${baseurl}
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "otp_type": "ACCOUNT_OPEN",
    ...     "otp": "g9zs6r6sj7bwW5pxC7SMyAMh4VTNzA9FvhAt4qh6hQI38Nboi+o8itVD4jwupJtuCiIkje9GDfHCIJCl83DVIwpHEj6zd7N2y6X3mO2qOO2WrrnZhqeKL3uvrBOoV/4e1+NFQQH8Tr7XRzxT6pgXf6o/AY2Kqraas38j6xDf3efJ50/GFZea1py3rGPMuGdLvfamiCT5ZJenzgDkIxfAqFRgwZi3/jKX61jncAZMXr/SOTllKQBHGfiRWDBHBxvvWiW7ilHLusqF19r+QuFSA6Luc/lgzSrLFyAVXfVKERfVwDSh6FyMvjuzaqoPKT+tue1CaNxC42fbfNBtM/cDfXPuKqBLGGnY5ADUswIO9GyvMsrEzZar2i1sVQ1FsAExIhr8KA2suMPdq9KL5a1LxZHiBc5/UeBkfskIZ3g5QPrE4NnxShSkQiLNabJf828wJaC3BvWimMfutXso4aVUaLf0xq+jGplnqQujR9ZppR0GLgdrDOojEnVXJDFckbFVEXIyELBhjTSV3D6wuzqJ8DuCkyWN/7nRHCl/sVhsEMdas+NgCXuW5P2nv69RAWAvLeTCIJpfDnmYtDpE1sVOG5Br+KVum/F3rWazoW4XsHOMOaDKWyG1YRHX9Q3NmIal37hSvYxxv75TgJfrX7FFTYO+w9ojlKeSWq8uutqDTgU="
    ...     }
    ${Response}=    POST On Session     baseUrl     ${otp_online_acc_opening}       data=${json}        headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Check verify invalid verify id
    [Arguments]     ${verify_id}    ${phone_number}
    Create Session      baseUrl     ${baseurl}
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "keyJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE2ODUwNzcxMzAsImV4cCI6MTY4NTA3ODAzMCwic2VydmljZXMiOlsidXNlci1wcm9maWxlIiwiYWNjb3VudC1zZXJ2aWNlIl0sImRldmljZV9pZCI6IjEyNjA4NjE5IiwicmVxdWVzdF9pZCI6IlppZDYxSzJ4UnJFVFl4OTYifQ.WwqcXi2dOlh0pe9chiwm3tADkFjyfYtFAOVNOxZy1F2BjXHRydWka-3eB67FAjn7q20Sw3FktJzBLkwyca1maA",
    ...     "otp_type": "ACCOUNT_OPENING",
    ...     "otp": "g9zs6r6sj7bwW5pxC7SMyAMh4VTNzA9FvhAt4qh6hQI38Nboi+o8itVD4jwupJtuCiIkje9GDfHCIJCl83DVIwpHEj6zd7N2y6X3mO2qOO2WrrnZhqeKL3uvrBOoV/4e1+NFQQH8Tr7XRzxT6pgXf6o/AY2Kqraas38j6xDf3efJ50/GFZea1py3rGPMuGdLvfamiCT5ZJenzgDkIxfAqFRgwZi3/jKX61jncAZMXr/SOTllKQBHGfiRWDBHBxvvWiW7ilHLusqF19r+QuFSA6Luc/lgzSrLFyAVXfVKERfVwDSh6FyMvjuzaqoPKT+tue1CaNxC42fbfNBtM/cDfXPuKqBLGGnY5ADUswIO9GyvMsrEzZar2i1sVQ1FsAExIhr8KA2suMPdq9KL5a1LxZHiBc5/UeBkfskIZ3g5QPrE4NnxShSkQiLNabJf828wJaC3BvWimMfutXso4aVUaLf0xq+jGplnqQujR9ZppR0GLgdrDOojEnVXJDFckbFVEXIyELBhjTSV3D6wuzqJ8DuCkyWN/7nRHCl/sVhsEMdas+NgCXuW5P2nv69RAWAvLeTCIJpfDnmYtDpE1sVOG5Br+KVum/F3rWazoW4XsHOMOaDKWyG1YRHX9Q3NmIal37hSvYxxv75TgJfrX7FFTYO+w9ojlKeSWq8uutqDTgU="
    ...     }
    ${Response}=    POST On Session     baseUrl     ${otp_online_acc_opening}       data=${json}        headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Check verify verify id is expired
    Create Session      baseUrl     ${baseurl}
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=095281427
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "eyJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE2ODUwNzQ4NzQsImV4cCI6MTY4NTA3NTc3NCwic2VydmljZXMiOlsidXNlci1wcm9maWxlIiwiYWNjb3VudC1zZXJ2aWNlIl0sImRldmljZV9pZCI6IjEyNjA4NjE5IiwicmVxdWVzdF9pZCI6InpXQWUzbHJiWlZJQjVnd0wifQ.fPmOfya_CVHuGe-7CyErVx6IMLxYokce70SSXfaUXDuOqHrU0ZYQs7GxrL3yM_dkNFLfAUuuy3kA_9NDvnODWg",
    ...     "otp_type": "ACCOUNT_OPENING",
    ...     "otp": "g9zs6r6sj7bwW5pxC7SMyAMh4VTNzA9FvhAt4qh6hQI38Nboi+o8itVD4jwupJtuCiIkje9GDfHCIJCl83DVIwpHEj6zd7N2y6X3mO2qOO2WrrnZhqeKL3uvrBOoV/4e1+NFQQH8Tr7XRzxT6pgXf6o/AY2Kqraas38j6xDf3efJ50/GFZea1py3rGPMuGdLvfamiCT5ZJenzgDkIxfAqFRgwZi3/jKX61jncAZMXr/SOTllKQBHGfiRWDBHBxvvWiW7ilHLusqF19r+QuFSA6Luc/lgzSrLFyAVXfVKERfVwDSh6FyMvjuzaqoPKT+tue1CaNxC42fbfNBtM/cDfXPuKqBLGGnY5ADUswIO9GyvMsrEzZar2i1sVQ1FsAExIhr8KA2suMPdq9KL5a1LxZHiBc5/UeBkfskIZ3g5QPrE4NnxShSkQiLNabJf828wJaC3BvWimMfutXso4aVUaLf0xq+jGplnqQujR9ZppR0GLgdrDOojEnVXJDFckbFVEXIyELBhjTSV3D6wuzqJ8DuCkyWN/7nRHCl/sVhsEMdas+NgCXuW5P2nv69RAWAvLeTCIJpfDnmYtDpE1sVOG5Br+KVum/F3rWazoW4XsHOMOaDKWyG1YRHX9Q3NmIal37hSvYxxv75TgJfrX7FFTYO+w9ojlKeSWq8uutqDTgU="
    ...     }
    ${Response}=    POST On Session     baseUrl     ${otp_online_acc_opening}       data=${json}        headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Check verify KYC 
    [Arguments]     ${verify_id}    ${phone_number}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${nid}    Get File For Streaming Upload     ${nid_image}
    ${userimg}    Get File For Streaming Upload    ${user_image}
    &{json}=          Create Dictionary    
    ...     verify_id=${verify_id[0]}
    &{files}=    Create Dictionary    national_id_card_photo=${nid}       customer_photo=${userimg}       operator_format=false   Content-Type=multipart/form-data
    ${Response}=    POST On Session     baseUrl     ${check_kyc}    data=${json}    files=&{files}       headers=${headers}      
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
    ${verify_id}        Get value from json     ${Response.json()}     $.data.verify_id
    ${phone}        Get value from json     ${Response.json()}     $.data.phone_number
    ${fist_name}    Get value from json     ${Response.json()}     $.data.first_name
    ${last_name}    Get value from json     ${Response.json()}     $.data.last_name
    ${first_name_kh}    Get value from json     ${Response.json()}     $.data.first_name_kh
    ${last_name_kh}     Get value from json     ${Response.json()}     $.data.last_name_kh
    ${gender}           Get value from json     ${Response.json()}     $.data.gender
    ${pob}      Get value from json     ${Response.json()}     $.data.pob 
    ${dob}      Get value from json     ${Response.json()}     $.data.dob 
    ${national_id}      Get value from json     ${Response.json()}     $.data.national_id
    ${expiry_date}      Get value from json     ${Response.json()}     $.data.expiry_date
    ${nationality}      Get value from json     ${Response.json()}     $.data.nationality
    ${customer_photo_url}       Get value from json     ${Response.json()}     $.data.customer_photo_url
    Set Suite Variable  ${fist_name}    
    Set Suite Variable  ${last_name}
    Set Suite Variable  ${verify_id}
    Set Suite Variable  ${phone}
    Set Suite Variable  ${first_name_kh}
    Set Suite Variable  ${last_name_kh}
    Set Suite Variable  ${gender}    
    Set Suite Variable  ${pob}
    Set Suite Variable  ${dob}
    Set Suite Variable  ${national_id}
    Set Suite Variable  ${expiry_date}
    Set Suite Variable  ${nationality}
    Set Suite Variable  ${customer_photo_url}
    Log     ${Response.json()}
Check verify KYC has existing
    [Arguments]     ${verify_id}    ${phone_number}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${nid}    Get File For Streaming Upload     ${vannak_nid}
    ${userimg}    Get File For Streaming Upload    ${vannak_img}
    &{json}=          Create Dictionary    
    ...     verify_id=${verify_id[0]}
    &{files}=    Create Dictionary    national_id_card_photo=${nid}       customer_photo=${userimg}       operator_format=false   Content-Type=multipart/form-data
    ${Response}=    POST On Session     baseUrl     ${check_kyc}    data=${json}    files=&{files}       headers=${headers}      
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
    check get response body for verify OTP      ${Response.json()}
    ${verify_id}        Get value from json     ${Response.json()}     $.data.verify_id
    ${phone}        Get value from json     ${Response.json()}     $.data.phone_number
    ${fist_name}    Get value from json     ${Response.json()}     $.data.first_name
    ${last_name}    Get value from json     ${Response.json()}     $.data.last_name
    ${first_name_kh}    Get value from json     ${Response.json()}     $.data.first_name_kh
    ${last_name_kh}     Get value from json     ${Response.json()}     $.data.last_name_kh
    ${gender}           Get value from json     ${Response.json()}     $.data.gender
    ${pob}      Get value from json     ${Response.json()}     $.data.pob 
    ${dob}      Get value from json     ${Response.json()}     $.data.dob 
    ${national_id}      Get value from json     ${Response.json()}     $.data.national_id
    ${expiry_date}      Get value from json     ${Response.json()}     $.data.expiry_date
    ${nationality}      Get value from json     ${Response.json()}     $.data.nationality
    ${customer_photo_url}       Get value from json     ${Response.json()}     $.data.customer_photo_url
    Set Suite Variable  ${fist_name}    
    Set Suite Variable  ${last_name}
    Set Suite Variable  ${verify_id}
    Set Suite Variable  ${phone}
    Set Suite Variable  ${first_name_kh}
    Set Suite Variable  ${last_name_kh}
    Set Suite Variable  ${gender}    
    Set Suite Variable  ${pob}
    Set Suite Variable  ${dob}
    Set Suite Variable  ${national_id}
    Set Suite Variable  ${expiry_date}
    Set Suite Variable  ${nationality}
    Set Suite Variable  ${customer_photo_url}
Request to CamDX without NID
    [Arguments]     ${verify_id}    ${phone_number}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    # ${nid}    Get File For Streaming Upload     ${nid_image}
    ${userimg}    Get File For Streaming Upload    ${user_image}
    &{json}=          Create Dictionary    
    ...     verify_id=${verify_id[0]}
    &{files}=    Create Dictionary       customer_photo=${userimg}       operator_format=false   Content-Type=multipart/form-data
    ${Response}=    POST On Session     baseUrl     ${check_kyc}    data=${json}    files=&{files}       headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Request to CamDX without User photo
    [Arguments]     ${verify_id}    ${phone_number}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${nid}    Get File For Streaming Upload     ${nid_image}
    # ${userimg}    Get File For Streaming Upload    ${user_image}
    &{json}=          Create Dictionary    
    ...     verify_id=${verify_id[0]}
    &{files}=    Create Dictionary       national_id_card_photo=${nid}       operator_format=false   Content-Type=multipart/form-data
    ${Response}=    POST On Session     baseUrl     ${check_kyc}    data=${json}    files=&{files}       headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Request to CamDX without User photo and NID
    [Arguments]     ${verify_id}    ${phone_number}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    
    &{json}=          Create Dictionary    
    ...     verify_id=${verify_id[0]}
    # ${nid}    Get File For Streaming Upload     ${nid_image}
    # ${userimg}    Get File For Streaming Upload    ${user_image}
    &{files}=    Create Dictionary      operator_format=false   Content-Type=multipart/form-data
    ${Response}=    POST On Session     baseUrl     ${check_kyc}    data=${json}   files=&{files}   headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Request to CamDX without request body
    [Arguments]     ${verify_id}    ${phone_number}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    
    &{json}=          Create Dictionary    
    ...     verify_id=${verify_id[0]}
    ${nid}    Get File For Streaming Upload     ${nid_image}
    ${userimg}    Get File For Streaming Upload    ${user_image}
    &{files}=    Create Dictionary      operator_format=false   Content-Type=multipart/form-data
    ${Response}=    POST On Session     baseUrl     ${check_kyc}               headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Request to CamDX with verify id expired
    [Arguments]    ${phone_number}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    &{json}=          Create Dictionary    
    ...     verify_id=${verify_id_expired}
    ${nid}    Get File For Streaming Upload     ${nid_image}
    ${userimg}    Get File For Streaming Upload    ${user_image}
    &{files}=    Create Dictionary      national_id_card_photo=${nid}       customer_photo=${userimg}      operator_format=false   Content-Type=multipart/form-data
    ${Response}=    POST On Session     baseUrl     ${check_kyc}        data=${json}   files=&{files}       headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
verify KYC information is correct
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}",
    ...     "last_name": "${last_name[0]}",
    ...     "first_name_kh": "${first_name_kh[0]}",
    ...     "last_name_kh": "${last_name_kh[0]}",
    ...     "gender": "${gender[0]}",
    ...     "pob": "${pob[0]}",
    ...     "dob": "${dob[0]}",
    ...     "national_id": "${national_id[0]}",
    ...     "expiry_date": "${expiry_date[0]}",
    ...     "nationality": "${nationality[0]}",
    ...     "customer_photo_url":"${customer_photo_url[0]}"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
    ${verify_id_kyc}    Get value from json  ${Response.json()}     $.data.verify_id
    ${phone_number_kyc}     Get value from json  ${Response.json()}     $.data.phone_number
    Set Suite Variable      ${verify_id_kyc}
    set Suite Variable      ${phone_number_kyc}
Verify KYC invalid verify id
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}t",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}",
    ...     "last_name": "${last_name[0]}",
    ...     "first_name_kh": "${first_name_kh[0]}",
    ...     "last_name_kh": "${last_name_kh[0]}",
    ...     "gender": "${gender[0]}",
    ...     "pob": "${pob[0]}",
    ...     "dob": "${dob[0]}",
    ...     "national_id": "${national_id[0]}",
    ...     "expiry_date": "${expiry_date[0]}",
    ...     "nationality": "${nationality[0]}",
    ...     "customer_photo_url":"${customer_photo_url[0]}"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Verify KYC invalid fist name en
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}t",
    ...     "last_name": "${last_name[0]}",
    ...     "first_name_kh": "${first_name_kh[0]}",
    ...     "last_name_kh": "${last_name_kh[0]}",
    ...     "gender": "${gender[0]}",
    ...     "pob": "${pob[0]}",
    ...     "dob": "${dob[0]}",
    ...     "national_id": "${national_id[0]}",
    ...     "expiry_date": "${expiry_date[0]}",
    ...     "nationality": "${nationality[0]}",
    ...     "customer_photo_url":"${customer_photo_url[0]}"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Verify KYC invalid last name en
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}",
    ...     "last_name": "${last_name[0]}t",
    ...     "first_name_kh": "${first_name_kh[0]}",
    ...     "last_name_kh": "${last_name_kh[0]}",
    ...     "gender": "${gender[0]}",
    ...     "pob": "${pob[0]}",
    ...     "dob": "${dob[0]}",
    ...     "national_id": "${national_id[0]}",
    ...     "expiry_date": "${expiry_date[0]}",
    ...     "nationality": "${nationality[0]}",
    ...     "customer_photo_url":"${customer_photo_url[0]}"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Verify KYC invalid first name kh
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}",
    ...     "last_name": "${last_name[0]}",
    ...     "first_name_kh": "${first_name_kh[0]}k",
    ...     "last_name_kh": "${last_name_kh[0]}",
    ...     "gender": "${gender[0]}",
    ...     "pob": "${pob[0]}",
    ...     "dob": "${dob[0]}",
    ...     "national_id": "${national_id[0]}",
    ...     "expiry_date": "${expiry_date[0]}",
    ...     "nationality": "${nationality[0]}",
    ...     "customer_photo_url":"${customer_photo_url[0]}"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Verify KYC invalid last name kh
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}",
    ...     "last_name": "${last_name[0]}",
    ...     "first_name_kh": "${first_name_kh[0]}",
    ...     "last_name_kh": "${last_name_kh[0]}k",
    ...     "gender": "${gender[0]}",
    ...     "pob": "${pob[0]}",
    ...     "dob": "${dob[0]}",
    ...     "national_id": "${national_id[0]}",
    ...     "expiry_date": "${expiry_date[0]}",
    ...     "nationality": "${nationality[0]}",
    ...     "customer_photo_url":"${customer_photo_url[0]}"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Verify KYC invalid gender
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}",
    ...     "last_name": "${last_name[0]}",
    ...     "first_name_kh": "${first_name_kh[0]}",
    ...     "last_name_kh": "${last_name_kh[0]}",
    ...     "gender": "${gender[0]}t",
    ...     "pob": "${pob[0]}",
    ...     "dob": "${dob[0]}",
    ...     "national_id": "${national_id[0]}",
    ...     "expiry_date": "${expiry_date[0]}",
    ...     "nationality": "${nationality[0]}",
    ...     "customer_photo_url":"${customer_photo_url[0]}"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Verify KYC invalid POB
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}",
    ...     "last_name": "${last_name[0]}",
    ...     "first_name_kh": "${first_name_kh[0]}",
    ...     "last_name_kh": "${last_name_kh[0]}",
    ...     "gender": "${gender[0]}",
    ...     "pob": "${pob[0]}t",
    ...     "dob": "${dob[0]}",
    ...     "national_id": "${national_id[0]}",
    ...     "expiry_date": "${expiry_date[0]}",
    ...     "nationality": "${nationality[0]}",
    ...     "customer_photo_url":"${customer_photo_url[0]}"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Verify KYC invalid DOB
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}",
    ...     "last_name": "${last_name[0]}",
    ...     "first_name_kh": "${first_name_kh[0]}",
    ...     "last_name_kh": "${last_name_kh[0]}",
    ...     "gender": "${gender[0]}",
    ...     "pob": "${pob[0]}",
    ...     "dob": "${dob[0]}t",
    ...     "national_id": "${national_id[0]}",
    ...     "expiry_date": "${expiry_date[0]}",
    ...     "nationality": "${nationality[0]}",
    ...     "customer_photo_url":"${customer_photo_url[0]}"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Verify KYC invalid national id
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}",
    ...     "last_name": "${last_name[0]}",
    ...     "first_name_kh": "${first_name_kh[0]}",
    ...     "last_name_kh": "${last_name_kh[0]}",
    ...     "gender": "${gender[0]}",
    ...     "pob": "${pob[0]}",
    ...     "dob": "${dob[0]}",
    ...     "national_id": "${national_id[0]}t",
    ...     "expiry_date": "${expiry_date[0]}",
    ...     "nationality": "${nationality[0]}",
    ...     "customer_photo_url":"${customer_photo_url[0]}"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Verify KYC invalid expiry date
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}",
    ...     "last_name": "${last_name[0]}",
    ...     "first_name_kh": "${first_name_kh[0]}",
    ...     "last_name_kh": "${last_name_kh[0]}",
    ...     "gender": "${gender[0]}",
    ...     "pob": "${pob[0]}",
    ...     "dob": "${dob[0]}",
    ...     "national_id": "${national_id[0]}",
    ...     "expiry_date": "${expiry_date[0]}k",
    ...     "nationality": "${nationality[0]}",
    ...     "customer_photo_url":"${customer_photo_url[0]}"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Verify KYC invalid nationality
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}",
    ...     "last_name": "${last_name[0]}",
    ...     "first_name_kh": "${first_name_kh[0]}",
    ...     "last_name_kh": "${last_name_kh[0]}",
    ...     "gender": "${gender[0]}",
    ...     "pob": "${pob[0]}",
    ...     "dob": "${dob[0]}",
    ...     "national_id": "${national_id[0]}",
    ...     "expiry_date": "${expiry_date[0]}",
    ...     "nationality": "${nationality[0]}k",
    ...     "customer_photo_url":"${customer_photo_url[0]}"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Verify KYC invalid customer photo url
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}",
    ...     "last_name": "${last_name[0]}",
    ...     "first_name_kh": "${first_name_kh[0]}",
    ...     "last_name_kh": "${last_name_kh[0]}",
    ...     "gender": "${gender[0]}",
    ...     "pob": "${pob[0]}",
    ...     "dob": "${dob[0]}",
    ...     "national_id": "${national_id[0]}",
    ...     "expiry_date": "${expiry_date[0]}",
    ...     "nationality": "${nationality[0]}",
    ...     "customer_photo_url":"${customer_photo_url[0]}k"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Verify KYC invalid all information
    [Arguments]     
    ...     ${fist_name}    
    ...     ${last_name}
    ...     ${verify_id}
    ...     ${first_name_kh}
    ...     ${last_name_kh}
    ...     ${gender}
    ...     ${pob}
    ...     ${dob}
    ...     ${national_id}
    ...     ${expiry_date}
    ...     ${nationality}
    ...     ${customer_photo_url}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json; charset=UTF-8
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id[0]}k",
    ...     "country_code": "855",
    ...     "phone_number": "${phone_number}",
    ...     "first_name": "${fist_name[0]}t",
    ...     "last_name": "${last_name[0]}t",
    ...     "first_name_kh": "${first_name_kh[0]}t",
    ...     "last_name_kh": "${last_name_kh[0]}t",
    ...     "gender": "${gender[0]}t",
    ...     "pob": "${pob[0]}t",
    ...     "dob": "${dob[0]}t",
    ...     "national_id": "${national_id[0]}t",
    ...     "expiry_date": "${expiry_date[0]}t",
    ...     "nationality": "${nationality[0]}t",
    ...     "customer_photo_url":"${customer_photo_url[0]}t"
    ...     }
    ${data} =  Encode String To Bytes     ${json}  UTF-8
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${verify_kyc}       data=${data}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}

Check create account with currency USD and KHR
    [Arguments]     ${verify_id_kyc}    ${phone_number_kyc}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number_kyc[0]}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id_kyc[0]}",
	...     "pin_code":"120101",
    ...     "city": "Phnom Penh",
    ...     "district": "Kombol",
    ...     "commune": "Kombol",
    ...     "village": "Thmor Da",
    ...     "purpose": "Savings",
    ...     "source_income": "SALARY",
	...     "occupation":"TRANSPORT_WORKER",
    ...     "address":null,
    ...     "industry":"Transportation",
    ...     "branch_code": "001",
    ...     "email": null,
    ...     "currency": 
    ...     [
    ...     "USD",
    ...     "KHR"
    ...     ]
    ...     }
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${create_account}       data=${json}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Check create account with currency USD
    [Arguments]     ${verify_id_kyc}    ${phone_number_kyc}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number_kyc[0]}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id_kyc[0]}",
	...     "pin_code":"120101",
    ...     "city": "Phnom Penh",
    ...     "district": "Kombol",
    ...     "commune": "Kombol",
    ...     "village": "Thmor Da",
    ...     "purpose": "Savings",
    ...     "source_income": "SALARY",
	...     "occupation":"TRANSPORT_WORKER",
    ...     "address":null,
    ...     "industry":"Transportation",
    ...     "branch_code": "001",
    ...     "email": null,
    ...     "currency": 
    ...     [
    ...     "USD"
    ...     ]
    ...     }
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${create_account}       data=${json}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Check create account with currency KHR
    [Arguments]     ${verify_id_kyc}    ${phone_number_kyc}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number_kyc[0]}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "${verify_id_kyc[0]}",
	...     "pin_code":"120101",
    ...     "city": "Phnom Penh",
    ...     "district": "Kombol",
    ...     "commune": "Kombol",
    ...     "village": "Thmor Da",
    ...     "purpose": "Savings",
    ...     "source_income": "SALARY",
	...     "occupation":"TRANSPORT_WORKER",
    ...     "address":null,
    ...     "industry":"Transportation",
    ...     "branch_code": "001",
    ...     "email": null,
    ...     "currency": 
    ...     [
    ...     "KHR"
    ...     ]
    ...     }
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${create_account}       data=${json}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}
Check create account expired verify id
        [Arguments]    ${phone_number_kyc}
    Create Session      baseUrl     ${baseurl}      
    ${headers}      Create Dictionary
    ...    Content-Type=application/json
    ...    x-api-key=${x-api-key}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    device_id=${phone_number_kyc[0]}
    ...    app_version=${app_version}
    ...    language=${language}
    ${json}     Catenate
    ...     {
    ...     "verify_id": "eyJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE2ODU1ODQzNzIsImV4cCI6MTY4NTU4NDY3Miwic2VydmljZXMiOlsiYWNjb3VudC1zZXJ2aWNlIl0sImNpZiI6IkVEMUtPWllReVZ5eWhMakoiLCJyZXF1ZXN0X2lkIjoiRUQxS09aWVF5Vnl5aExqSiIsImRldmljZV9pZCI6IjEyNjAwNjE5In0.8-UR8-HlXfcjeOsNOwGpKGzMMSJJKIRoEdQWfGMe1hZ6YDEAizFIaJFm9DjmWfIXG029wDcAiEgnV2tZT1tRSg",
	...     "pin_code":"120101",
    ...     "city": "Phnom Penh",
    ...     "district": "Kombol",
    ...     "commune": "Kombol",
    ...     "village": "Thmor Da",
    ...     "purpose": "Savings",
    ...     "source_income": "SALARY",
	...     "occupation":"TRANSPORT_WORKER",
    ...     "address":null,
    ...     "industry":"Transportation",
    ...     "branch_code": "001",
    ...     "email": null,
    ...     "currency": 
    ...     [
    ...     "KHR"
    ...     ]
    ...     }
    Log     ${json}
    ${Response}=    POST On Session     baseurl     ${create_account}       data=${json}    headers=${headers}      expected_status=anything
    [Return]        ${Response}
    check get response body for verify OTP      ${Response.json()}