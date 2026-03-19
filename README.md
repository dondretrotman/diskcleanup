# diskcleanup
Linux script to free up hard drive space
  
This is just a little script I wrote so that my tinty hard drive (30gb) could run Ubuntu. 
  
It runs in fivve stages:
- Stage 1: Remove uneeded packages
- Stage 2: Clean apt cache
- Stage 3: Clear systemd journal logs except for the last week
- Stage 4: Remove old linux headers (disabled by default)
