#1
sudo apt update -y

#2
pkgs='apache2'
install=false
for pkg in $pkgs; do
  status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
  if [ ! $? = 0 ] || [ ! "$status" = installed ]; then
    install=true
    break
  fi
done
if "$install"; then
  sudo apt install $pkgs
fi

#3
servstat=$(service apache2 status)

if [[ $servstat == *"active (running)"* ]]; then
  echo "process is running"
else echo "process is not running"
fi

#4
# sudo systemctl status apache2

#5
find /var/log/apache2/ -type f -name '*.log' -print | while read FILE ; do
    BASENAME=`basename ${FILE} '.log'`
    cp ${FILE} /tmp/${BASENAME}.log
    cat > ${FILE} << EOF
EOF
done

#6
sudo tar -czvf /tmp/devkrishnagupta-httpd-logs-`date +%d-%m-%Y`.tar /tmp/*.log

