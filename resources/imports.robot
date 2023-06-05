*** Settings ***
Library  SeleniumLibrary
Library  Selenium2Library
Library  RequestsLibrary
Library  JSONLibrary
Library   Collections
Library    BuiltIn
Library  String
Library  DateTime
Library   OperatingSystem
Variables    config.yaml
Resource                  ../keywords/Verify_success.robot

