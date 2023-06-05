#! /bin/bash
echo "************************go to test directory**********************"
cd ../testcases
echo ${pwd}
echo "*************************Start Testing****************************************"
robot --variable env:qa  --outputdir ../results online_account_opening.robot
#robot --variable env:qa  --outputdir ../results mobile_payment.robot
#robot --variable env:qa --outputdir ../results -i transfer_own mobile_payment.robot
echo "**************************published results*************************"