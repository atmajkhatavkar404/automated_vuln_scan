# automated_vuln_scan
### **Explanation of Tools Used**:

1. **Amass**: A powerful subdomain enumeration tool for discovering subdomains.
   ```bash
   sudo apt install amass
   ```

2. **Sublist3r**: A subdomain discovery tool that uses search engines to find subdomains.
   ```bash
   sudo apt install sublist3r
   ```

3. **Nmap**: Used for port scanning, service detection, and some basic vulnerability scanning.
   ```bash
   sudo apt install nmap
   ```

4. **Nikto**: A web vulnerability scanner that detects common web application vulnerabilities.
   ```bash
   sudo apt install nikto
   ```

5. **SQLMap**: An automated SQL injection detection and exploitation tool.
   ```bash
   sudo apt install sqlmap
   ```

6. **Gobuster**: A directory and file brute-forcing tool, useful for finding hidden files and directories.
   ```bash
   sudo apt install gobuster
   ```

7. **Dirsearch**: A fast directory brute-forcing tool to discover web directories and files.
   ```bash
   git clone https://github.com/maurosoria/dirsearch.git
   ```

8. **SSLScan**: Used to test SSL/TLS configurations for potential vulnerabilities.
   ```bash
   sudo apt install sslscan
   ```

9. **OpenVAS**: A comprehensive vulnerability scanner that can detect a wide range of vulnerabilities in network services and applications.
   ```bash
   sudo apt install openvas
   ```

### **How to Run the Script**:

1. **Save the Script**: Copy the script into a file, e.g., `automated_vuln_scan.sh`.

2. **Make the Script Executable**:
   ```bash
   chmod +x automated_vuln_scan.sh
   ```

3. **Run the Script**:
   ```bash
   ./automated_vuln_scan.sh example.com
   ```

### **Installation of Required Tools**:

To install all the required tools on Kali Linux, you can use the following commands:

```bash
sudo apt update
sudo apt install amass sublist3r nmap nikto sqlmap gobuster sslscan openvas
git clone https://github.com/maurosoria/dirsearch.git
```

### **What This Script Automates**:

1. **Subdomain Enumeration**:
   - Uses **Amass** and **Sublist3r** to find subdomains.
   - Combines and de-duplicates the results.

2. **Port Scanning**:
   - Uses **Nmap** to scan all discovered subdomains for open ports and services.

3. **Web Vulnerability Scanning**:
   - Uses **Nikto** to scan each subdomain for common web vulnerabilities.

4. **SQL Injection Testing**:
   - Uses **SQLMap** to detect SQL injection vulnerabilities in the web applications hosted on the subdomains.

5. **Directory Brute-forcing**:
   - Uses both **Gobuster** and **Dirsearch** to brute-force directories and files on the subdomains.

6. **SSL/TLS Vulnerability Scanning**:
   - Uses **SSLScan** to check for SSL/TLS vulnerabilities on each subdomain.

7. **Comprehensive Vulnerability Scanning**:
   - Uses **OpenVAS** to perform an extensive vulnerability scan on the target.

### **Output**:
- Results are saved in an output directory named after the target domain or IP, with detailed logs from each tool.
