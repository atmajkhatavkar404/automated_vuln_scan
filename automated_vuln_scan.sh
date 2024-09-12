#!/bin/bash

# Check if a domain/IP is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <domain_or_ip>"
  exit 1
fi

TARGET=$1
OUTPUT_DIR="$TARGET"_scan_results
WORDLIST="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"

# Create output directory
mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

echo "[+] Starting full automation for vulnerability scanning on $TARGET"
echo "[+] Output will be saved in $OUTPUT_DIR"

# 1. Subdomain Enumeration with Amass
echo "[+] Running Amass for subdomain enumeration..."
amass enum -d $TARGET -o amass_subdomains.txt

# 2. Subdomain Enumeration with Sublist3r
echo "[+] Running Sublist3r for subdomain enumeration..."
sublist3r -d $TARGET -o sublist3r_subdomains.txt

# Combine subdomains and remove duplicates
echo "[+] Combining subdomain results and removing duplicates..."
cat amass_subdomains.txt sublist3r_subdomains.txt | sort -u > all_subdomains.txt

echo "[+] Total subdomains found:"
wc -l all_subdomains.txt

# 3. Port Scanning with Nmap
echo "[+] Running Nmap for port scanning and service detection..."
nmap -sC -sV -oN nmap_scan.txt -iL all_subdomains.txt

# 4. Web Vulnerability Scanning with Nikto
echo "[+] Running Nikto for web vulnerability scanning..."
for subdomain in $(cat all_subdomains.txt); do
  nikto -h http://$subdomain -o nikto_scan_$subdomain.txt
done

# 5. SQL Injection Scanning with SQLMap
echo "[+] Running SQLMap to test for SQL Injection vulnerabilities..."
for subdomain in $(cat all_subdomains.txt); do
  sqlmap -u "http://$subdomain" --batch --crawl=3 --output-dir=sqlmap_scan_$subdomain
done

# 6. Directory Brute-Forcing with Gobuster
echo "[+] Running Gobuster to brute-force directories and files..."
for subdomain in $(cat all_subdomains.txt); do
  gobuster dir -u http://$subdomain -w $WORDLIST -o gobuster_$subdomain.txt
done

# 7. Directory Brute-Forcing with Dirsearch
echo "[+] Running Dirsearch for additional directory brute-forcing..."
for subdomain in $(cat all_subdomains.txt); do
  dirsearch -u http://$subdomain -e php,html,js -o dirsearch_$subdomain.txt
done

# 8. SSL/TLS Vulnerability Scanning with SSLScan
echo "[+] Running SSLScan for SSL/TLS vulnerability scanning..."
for subdomain in $(cat all_subdomains.txt); do
  sslscan $subdomain > sslscan_$subdomain.txt
done

# 9. Vulnerability Scanning with OpenVAS
echo "[+] Running OpenVAS for comprehensive vulnerability scanning..."
gvm-cli tls --hostname $TARGET --xml "<get_tasks/>" > openvas_scan_$TARGET.txt

echo "[+] Full vulnerability scanning automation completed for $TARGET."
echo "[+] All results are saved in the $OUTPUT_DIR directory."
#Mr.Error
