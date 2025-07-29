# Joomla Website (Guide to restore the website)
- Author: Andro Fhaily (Software enginner student) 
- Main Purpose of this project: This project automates setup, backup, restore, and cleanup of a Joomla website and MySQL database using Docker containers. We also built a website with 30 concepts on it and we were required to save it in our project as well.

## Project Contents

- `setup.sh`: Script to set up needed Docker containers including setup up a network.
- `backup.sh`: Script to back up Joomla and MySQL data.
- `restore.sh`: Script to restore from backups.
- `cleanup.sh`: Script to clean up Docker containers and volumes.
- `joomla.backup.tar.gz`: Compressed backup archive (Includes my SQLdata file and Website information file such as design etc).. 

Step by step guide to restore my website: 

- Clone our repo:
git clone https://github.com/Fielding27/Joomla-.git

- Enter the saved folder now:
cd Joomla-

- Run the setup script from the folder:
chmod +x setup.sh
./setup.sh

- Restore the needed files (Automatically does all restores zips the files and does everything automatically.)
chmod +x restore.sh
./restore.sh

- In order to access the website use the following link:
http://localhost:8080

- In the end in order to clean everything from your computer use the following command:
chmod +x cleanup.sh
./cleanup.sh

Details about our scripts:
## How to Use
1. Run `setup.sh` to start Joomla and MySQL containers.
2. Run `backup.sh` to create a backup archive.
3. Run `restore.sh` to restore the site and database from the backup.
4. Run `cleanup.sh` to remove all containers, images, and volumes.



## Requirements
- Docker
- Bash shell
- Linux or Windows with WSL



## Contact
For questions, contact me at Fhailyandro4@gmail.com
Thank you for using our website :)
