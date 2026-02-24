# 🧹 Log Cleanup Automation Scripts

This repository contains automated Linux shell scripts used for identifying and safely deleting old files based on modification time. These scripts are designed following real production standards used in enterprise environments (banking, servers, DevOps systems).

---

## 📂 Scripts Included

### 1️⃣ scan_old_files.sh

**Purpose:**
Scans a target directory and lists files older than a specified number of days.

**Features**

* Searches recursively
* Filters only files (not folders)
* Stores results in snapshot file
* Captures file path + last modified timestamp

**Logic**

* Uses `find` command
* Saves results to:

  ```
  /tmp/files_to_delete.txt
  ```

**Command Used**

```bash
find "$TARGET_DIR" -type f -mtime +90 -printf "%p|%T@\n"
```

---

### 2️⃣ delete_old_files.sh

**Purpose:**
Safely deletes files listed in snapshot only if they were not modified after scan.

**Features**

* Reads snapshot file
* Verifies file still exists
* Checks timestamp integrity
* Logs all actions
* Skips modified or missing files

**Safety Validation Logic**

```
if current_modified_time == scanned_time
→ delete
else
→ skip
```

**Log File**

```
/var/log/delete_old_files.log
```

---

## ⚙️ How It Works Together

Step 1 → Scan script runs 1st of every month
Step 2 → Generates snapshot file
Step 3 → Sends report mail
Step 4 → Delete script runs on scheduled date (5th)
Step 5 → Deletes only verified files

---

## ⏰ Cron Job Setup

Open crontab:

```bash
crontab -e
```

Add jobs:

 ### 1st of evey month Scan Job

```bash
0 1 1 * * /full/path/scan_old_files.sh```

### Monthly Deletion Job (5th day)

```bash
0 2 5 * * /scripts/delete_old_files.sh
```

---

## 📧 Email Notification

System sends automated email report listing files scheduled for deletion.

Requirement:

```
mailutils package installed
```

Install if missing:

```bash
sudo apt install mailutils
```

---

## 🔐 Permissions Setup

Make scripts executable:

```bash
chmod +x scan_old_files.sh delete_old_files.sh
```

---

