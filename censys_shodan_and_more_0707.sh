
# ================================================================
# $1 : Target IP
# $2 : Target URL
# $3 : CVE Value e.g. CVE-2018-8011

# ISC Sans
/usr/bin/chromium-browser --headless --disable-gpu --dump-dom https://isc.sans.edu/ipinfo.html?ip=$1	 > sans/$1.html
sudo systemctl restart tor; sleep 2 
 
# Talos Intelligence
/usr/bin/chromium-browser --headless --disable-gpu --dump-dom https://www.talosintelligence.com/reputation_center/lookup?search=$1	 > talos/$1.html
sudo systemctl restart tor; sleep 2 

# Shodan
# proxychains4 -f ~/proxychains.conf wget https://www.shodan.io/host/$1  --output-file=shodan/$1.htm
wget https://www.shodan.io/host/$1  --output-file=shodan/$1.htm

# Censys
# wget https://censys.io/ipv4/$1  --output-file=censys/$1.htm
/usr/bin/chromium-browser --headless --disable-gpu --dump-dom --proxy-server="socks5://localhost:9050" --host-resolver-rules="MAP * ~NOTFOUND , EXCLUDE localhost" https://censys.io/ipv4/$1 > censys/$1.htm
sudo systemctl restart tor; sleep 2 

# ----------------------------------------------------------------
# Transparency Report - Google
/usr/bin/chromium-browser --headless --dump-dom https://transparencyreport.google.com/safe-browsing/search?url=$2 > trep/$2.html

# ----------------------------------------------------------------
# CVE
/usr/bin/chromium-browser --headless --disable-gpu --dump-dom --proxy-server="socks5://localhost:9050" --host-resolver-rules="MAP * ~NOTFOUND , EXCLUDE localhost" https://nvd.nist.gov/vuln/detail/$3 > CVE/$3.htm 
sudo systemctl restart tor; sleep 2 

# ================================================================
