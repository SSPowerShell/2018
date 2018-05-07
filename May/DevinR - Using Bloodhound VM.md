# General info

I've created a ready to go BloodHound toolkit for you. It includes the ingestors (to get the data from a domain), BloodHound exe for analyzing the data, and a Kali linux VM (.vdi for use with VirtualBox - is 5GB) to host the neo4j database for BloodHound. I'd suggest that you download all three.

You can find lots of guides for setting up a BloodHound neo4j server, so you don't have to use my VM if you don't want to.

Getting the BloodHound VM
========

Download the torrent and select which files you want to take. 

Setting up the VM
========

Create a VM in virtualbox, set to Ubuntu64bit, select "use an existing virtual hard disk file" and browse to the downloaded Kali.vdi (stop torrenting so that the file isn't locked), accept all other defaults.

Edit the settings for the machine and make sure that your networking selection works (you need to be able to access the VM from whatever computer will run BloodHound.exe). I normally select Bridged Adapter so that the VM is on my LAN just like any other PC.

Boot the VM.

Logging in to the VM
========

The username is `root` and the password is `toortoor`.

Also, get the IP address of the VM. I like to just right click the little Network cable in the top right of the screen and select "Connection Information" to view the IP address.

Running the Neo4j server
========

Open a shell and either hit up a few times or type: `neo4j console`

Accessing the Neo4j server from BloodHound
========

Run BloodHound.exe and type in: `bolt://<ipaddress>`

Username: `neo4j`

Password: `toortoor`
