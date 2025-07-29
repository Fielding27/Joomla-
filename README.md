# Joomla Docker Backup and Restore
Author: Andro Fhaily (Software enginner student)
 Main Purpose of this project: This project automates setup, backup, restore, and cleanup of a Joomla website and MySQL database using Docker containers. We also built a website with 30 concepts on it and we were required to save it in our project as well.
Whats been done on this project :
## Project Contents

- `setup.sh`: Script to set up needed Docker containers including setup up a network.
- `backup.sh`: Script to back up Joomla and MySQL data.
- `restore.sh`: Script to restore from backups.
- `cleanup.sh`: Script to clean up Docker containers and volumes.
- `joomla.backup.tar.gz`: Compressed backup archive (Includes my SQLdata file and Website information file such as design etc).. 

Step by step guide to restore my website: 

Clone our repo:
git clone https://github.com/Fielding27/Joomla-.git

Enter the saved folder now:
cd Joomla-

Run the setup script from the folder:
chmod +x setup.sh
./setup.sh

Restore the needed files (Automatically does all restores zips the files and does everything automatically.)
chmod +x restore.sh
./restore.sh

In order to access the website use the following link:
http://localhost:8080

In the end in order to clean everything from your computer use the following command:
chmod +x cleanup.sh
./cleanup.sh

Thank you for using our website :)

