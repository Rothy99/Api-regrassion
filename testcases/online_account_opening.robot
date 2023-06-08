*** Settings ***
Resource                  ../keywords/online_account_opening_keyword.robot

*** Test Case ***
Online account opening - Check verify phone number
    [Tags]      Positive
    verify phone number 
Online account opening - Check Validation otp is corrected
    [Tags]      Positive
    Check verify OTP    ${verify_id}  ${phone_number}
Online account opening - Check verify phone number has existing
    [Tags]      Negative
    Verify phone number existing
Online account opening - Check Validation otp is incorrected
    [Tags]      Negative
    Check verify OTP incorrect   ${verify_id}  ${phone_number}
Online account opening - Check validation incorrect otp type from request body
    [Tags]      Negative
    Check verify incorrect OTP type     ${verify_id}  ${phone_number}
Online account opening - Check validation invalid verity id
    [Tags]      Negative
    Check verify invalid verify id     ${verify_id}  ${phone_number}
Online account opening - heck validation verify id is expired
    [Tags]      Negative
    Check verify verify id is expired
Online account opening - Check request KYC to CamDX 
    [Tags]      Positive
    Check verify KYC     ${verify_id}  ${phone_number}
Online account opening - Check validation request KYC to CamDX without NID
    [Tags]      Negative
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Request to CamDX without NID    ${verify_id}  ${phone_number}
Online account opening - Check validation request KYC to CamDX without user photo
    [Tags]      Negative
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Request to CamDX without User photo    ${verify_id}  ${phone_number}
Online account opening - Check validation request KYC to CamDX without user photo and NID
    [Tags]      Negative
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Request to CamDX without User photo and NID    ${verify_id}  ${phone_number}
Online account opening - Check validation request KYC to CamDX without request body
    [Tags]      Negative
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Request to CamDX without request body     ${verify_id}  ${phone_number}
Online account opening - Check validation request KYC to CamDX verify id expired
    [Tags]      Negative
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Request to CamDX with verify id expired     ${phone_number}
Online account opening - Check verify KYC information correct
    [Tags]      Positive   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC information is correct    
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
Online account opening - Check verify KYC has existing
        [Tags]      Positive   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Check verify KYC has existing   ${verify_id}  ${phone_number}
    Verify KYC information is correct    
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
Online account opening - Check verify KYC invalid verify id
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC invalid verify id    
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
Online account opening - Check verify KYC invalid fist name
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC invalid fist name en
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
Online account opening - Check verify KYC invalid last name
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC invalid last name en   
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
Online account opening - Check verify KYC invalid first name kh
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC invalid first name kh
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
Online account opening - Check verify KYC invalid last name kh
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC invalid last name kh   
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
Online account opening - Check verify KYC invalid gender
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC invalid gender   
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
Online account opening - Check verify KYC invalid POB
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC invalid POB  
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
Online account opening - Check verify KYC invalid DOB
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC invalid DOB   
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
Online account opening - Check verify KYC invalid national id
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC invalid national id    
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
Online account opening - Check verify KYC invalid expiry date
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC invalid expiry date    
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
Online account opening - Check verify KYC invalid nationality
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC invalid nationality   
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
Online account opening - Check verify KYC invalid customer photo url
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC invalid customer photo url    
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
Online account opening - Check verify KYC invalid all information
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC invalid all information  
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
Online account opening - Check create acccount with currency USD and KHR
    [Tags]      Positive   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC information is correct    
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
    Check create account with currency USD and KHR    ${verify_id_kyc}  ${phone_number_kyc}
# Check create acccount with currency USD
#     [Tags]      Positive   
#     verify phone number 
#     Check verify OTP    ${verify_id}  ${phone_number}
#     Check verify KYC     ${verify_id}  ${phone_number}
#     Verify KYC information is correct    
#     ...     ${fist_name}    
#     ...     ${last_name}
#     ...     ${verify_id}
#     ...     ${first_name_kh}
#     ...     ${last_name_kh}
#     ...     ${gender}
#     ...     ${pob}
#     ...     ${dob}
#     ...     ${national_id}
#     ...     ${expiry_date}
#     ...     ${nationality}
#     ...     ${customer_photo_url}
#     Check create account with currency USD    ${verify_id_kyc}  ${phone_number_kyc}
# Check create acccount with currency KHR
#     [Tags]      Positive   
#     verify phone number 
#     Check verify OTP    ${verify_id}  ${phone_number}
#     Check verify KYC     ${verify_id}  ${phone_number}
#     Verify KYC information is correct    
#     ...     ${fist_name}    
#     ...     ${last_name}
#     ...     ${verify_id}
#     ...     ${first_name_kh}
#     ...     ${last_name_kh}
#     ...     ${gender}
#     ...     ${pob}
#     ...     ${dob}
#     ...     ${national_id}
#     ...     ${expiry_date}
#     ...     ${nationality}
#     ...     ${customer_photo_url}
#     Check create account with currency KHR    ${verify_id_kyc}  ${phone_number_kyc}
Online account opening - Check create acccount with expired verify id
    [Tags]      Negative   
    verify phone number 
    Check verify OTP    ${verify_id}  ${phone_number}
    Check verify KYC     ${verify_id}  ${phone_number}
    Verify KYC information is correct    
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
    Check create account expired verify id  ${phone_number_kyc}
