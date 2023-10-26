# NYCU-SA
- **Instructor**: 蔡孟勳 Meng-Hsun Tsai
- **Semester**: NYCU-112-1
- **Pre-requisites**:
    - Basic knowledge of UNIX commands
    - Basic Programming skills
    - Basics of TCP/IP Networking
    - Your ***HARD STUDY***
- **Grading**
    - Mid 15%
    - Final 15%
    - Homeworks 70%
- **Credit**: 3
- **Contact**: 
    - TR: tsaimh@cs.nycu.edu.tw
    - TA: ta@nasa.cs.nycu.edu.tw
- Reference Website:
    1. NYCU-SA-2023: https://nasa.cs.nycu.edu.tw/sa/2023/
    2. NASA-OJ: https://nasaoj.cs.nycu.edu.tw
    3. ShellCheck: https://www.shellcheck.net
## HW1
**Install FreeBSD / Ubuntu & WireGuard**
- Basic(15%)
    - Install FreeBSD 13.2-RELEASE
    - Alternatively, Install Ubuntu 22.04
- Root on ZFS (15%)
    - Zpool name : zroot (rpool on Ubuntu)
- Add a user and a group
    - User should also be in the "wheel" group ("sudo" on Ubuntu)
    - Use this user to do this homework instead of root (using sudo)
- Add a user called "judge" for Online Judge
    - User should also be in the "wheel" ("sudo" on ubuntu) group
    - Please use "sh" as default shell (10%)
    - This user needs to run sudo without password (15%)
- Set your machine to current time zone and adjust current time (10%)
    - CST
- Enable sshd (20%)
    - Install this public key to your /home/judge/.ssh/ for Online Judge.
        ```sh
        $ fetch https://nasa.cs.nctu.edu.tw/sa/2023/nasakey.pub
        $ cat nasakey.pub >> /home/judge/.ssh/authorized_ke
        ```
    - You can use Fingerprint to check "nasakey.pub"
        ```sh
        $ ssh-keygen -l -f nasakey.pub
        256 SHA256:0LO0tdbs1Q5q4J8wa4Hidej2gkq9gqtLQeJwm98VYZk sa-2023 (ED25519)
        ```
- Install Wireguard
    - Configure the connection
    - Configuration directory: /usr/local/etc/wireguard/wg0.conf
    - Use `wg-quic` and `wg` to start/stop the connection
## HW2
**Shell Script**