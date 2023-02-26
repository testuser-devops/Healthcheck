ls
systemctl --type=service >>usagereport
cat usagereport
git add .
git commit -m "new commit by jenkins"
git push -u origin main
