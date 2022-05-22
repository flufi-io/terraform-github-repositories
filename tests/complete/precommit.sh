#!/bin/bash
cd tests/complete
rm -rf go.*
export GOOS=linux GOARCH=amd64 CGO_ENABLED=0
go mod init test
go mod tidy >> /dev/null
GITHUB_TOKEN=`grep token ~/.config/gh/hosts.yml | sed "s/.*gh/gh/g"` go test -count=1 -timeout 120m -v ./...
TESTS_EXIT=$?
cd ../../
find . -type f -name ".*lock*" -prune -exec rm -rf {} \;
find . -type d -name ".terraform" -prune -exec rm -rf {} \;
#find . -type d -name ".tfstate" -prune -exec rm -rf {} \;
exit $TESTS_EXIT
