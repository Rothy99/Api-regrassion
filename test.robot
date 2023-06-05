*** Settings ***
Library     RequestsLibrary
Library     String

*** Test Cases ***
Check KYC
    Example Test Case
Test push notification
    API push notification
*** Keywords ***

API push notification
   ${headers}=     Create Dictionary    #create header dictionary
   ...       accept=application/json
   ...       Content-Type=application/json
   ...       client_id=12345
   ...       client_secret=12345_secret
   ...       x-api-key=12345_api_key
   ${external_reference}=     Generate Random String    32    [LETTERS][NUMBERS]
   ${json}      Catenate    #create json data
   ...  {
   ...  "service_id": "online_pay_otp",
   ...  "batch_id": "0001",
   ...  "body": [
   ...   {
   ...    "external_reference": "${external_reference}",
   ...    "cif": "001088774",
   ...    "data": {
   ...     "currency": "USD",
   ...     "amount": "1.68",
   ...     "otp_code": "123456",
   ...     "merchant_name": "Momo Shop",
   ...     "card_mask": "4763****5670"
   ...    }
   ...   }
   ...  ]
   ...  }
   log    ${json}
   Create Session  session     http://api-uat-internal.hatthabank.com      disable_warnings=1   verify=False      # create sesssion with the main URL
   ${resp}=     POST On Session  session      notification-service/api/1.0/information/ext-notification/send     data=${json}    headers=${headers}    expected_status=anything    # create post request with body and header
   log    ${resp.json()}


Example Test Case
    ${url}=        Set Variable    http://api-uat-internal.hatthabank.com
    ${url_path}=        Set Variable    account-service/api/v1.0/account-opening/kyc/check?=
    ${verify_id}=  Set Variable    eyJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE2ODUzNDY2MjQsImV4cCI6MTY4NTM0NzUyNCwic2VydmljZXMiOlsidXNlci1wcm9maWxlIiwiYWNjb3VudC1zZXJ2aWNlIl0sInJlcXVlc3RfaWQiOiJOZlFzcU1kZGQ5RjZvWklZIiwiZGV2aWNlX2lkIjoiMTI2MDg2MTkiLCJ2YWxpZGF0ZWQiOnRydWV9.RbuEf6IyuqIXhrhmlPybezhnkeKioEoAbc-vau9007OYbQ2Hv_y8Is01Q2bUr4CSHSQyO3LytCvX80dk8VS6yg
    ${nid_file}=   Set Variable    nid.jpg
    ${userimg}=    Set Variable    userimg.jpg
    ${headers}=    Create Dictionary    Content-Type=multipart    app_version=3.1.0    client_id=12345    client_secret=12345_secret    device_id=12608619    language=en    x-api-key=12345_api_key
    ${data}=       Create Dictionary    verify_id=${verify_id}    national_id_card_photo=${nid_file}    customer_photo=${userimg}
    Create Session  session     ${url}      disable_warnings=1   verify=False      # create sesssion with the main URL
    ${resp}=     POST On Session  session      ${url_path}     data=${data}    headers=${headers}    expected_status=anything    # create post request with body and header
    Log            ${resp.json}
#   [Return]       ${response}
    should be equal as integers     ${resp.status_code}     200   Erorr while trying to login we get status ${resp.status_code}