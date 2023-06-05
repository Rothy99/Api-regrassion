*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  JSONLibrary
Library   Collections
Library    BuiltIn
Library  String
Library  DateTime
Library   OperatingSystem
Variables    config.yaml
Resource                  ../keywords/Verify_success.robot

