# SSH Brute-Force Monitor & WhatsApp Alerter 🛡️📱

This project is a lightweight security automation tool that monitors system logs for SSH brute-force attempts and sends real-time alerts via WhatsApp.

## 🚀 Key Features
* **Automated Log Analysis:** Periodically scans `/var/log/auth.log` for failed login attempts.
* **Smart Alerting:** Filters and identifies attackers who exceed a threshold (3+ attempts).
* **WhatsApp Integration:** Sends instant security notifications using **GREEN-API**.
* **Dockerized Environment:** Wrapped in a Docker container for seamless deployment on any server.

## 🛠️ Tech Stack
* **Bash Scripting** (Logic & Parsing)
* **Docker** (Containerization)
* **Linux Security** (Auth logs monitoring)
* **REST API** (Integration with GREEN-API)

## 📦 Installation & Setup

1. **Clone the project:**
   ```bash
   git clone [https://github.com/bekbolat2700-collab/security_project.git](https://github.com/bekbolat2700-collab/security_project.git)
   cd security_project
