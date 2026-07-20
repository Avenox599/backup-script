# Backup Script


## Description
This script creates a compressed backup of a directory and automatically deletes backups older than 14 days to free up disk space.

## Requirement
The requirement of this projet is:
- Using a Linux distribution or a system can using bash
- Administrator privileges (sudo)

## Usage
You can use this program with two method.
### First method
The structure of first method is: 
```bash 
sudo ./backup.sh <directory>
```
#### Example
For this example, I save the directory Documents (It locate in /home/emmanuel)
```bash
sudo ./backup.sh /home/emmanuel/Documents
```
### Second method
The structure of second method is: 
```bash 
sudo ./backup.sh
```
With second method The script will prompt you to enter the absolute path of the directory you want to back up.

## Features
The feature of this program is:
- Create a compressed (.tar.gz) backup
- Delete the backups of more of 14 days

## Example Output
```
[SUCCESS] Backup completed successfully.
[INFO] Archive created: backup_2026-07-16_14-30-10.tar.gz
```
## Licence
This projet is licensed under the MIT License.
# Author
Emmanuel
