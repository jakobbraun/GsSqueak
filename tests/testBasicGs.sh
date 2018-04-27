#!/bin/sh

set -xe


exit_code=0

# Read configuration file containing categories to be tested
while read -r name
do
  echo "Executing tests in ${name}"
  startTopaz ${STONE_NAME} -l << EOF
run

%
EOF
done < gs-tests.conf 

#startTopaz $name -l << EOF
#run
#(ClassOrganizer _newWithRoot: Object symbolList: (GsSession currentSession symbolList) env: 0) categories keys asArray sortAscending
#%
#EOF

if [ $exit_code != 0 ]
then
  echo "Errored: There are tests which failed or errored" >&2
fi

exit $exit_code
