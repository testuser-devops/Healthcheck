ls
systemctl list-10 --type=service --state=active >>usagereport
cat usagereport
git config --global --add safe.directory '*'
git config --global user.email "test.tester9676@gmail.com"
git config --global user.name "testuser-devops"
git add .
git commit -m "new commit by jenkins"
git push -u origin main


