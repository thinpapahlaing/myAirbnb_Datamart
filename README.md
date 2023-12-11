# Project: Building "myAirbnb_Datamart" Database
## By Thin Pa Pa Hlaing

Nowadays, there is a constantly increasing rate of travelers around the world and it's getting difficult to have a place for temporary residing in the traveling places. For this purpose, designing and developing the Datamart-myAirbnb database is conducted.

### Project Description
Designing, and Developing a database (myAirbnb_Datamart) to make a system of online renting and booking properties storing users, properties, and payments data

### Project Aim
* For Guests - To comfortably and easily rent properties online from anywhere in the world with internet 
* For Hosts - To conveniently showcase their properties and connect with guests across the world

### Database Design (Entity Relationship Model)
![Image](https://github.com/thinpapahlaing/myAirbnb_Datamart/blob/main/Entity%20Relationship%20Model.png)

### Features of "myAirbnb_Datamart" Database
* 21 Entities
* SQL Documentation of 21 Entities
* At least 20 entries of Realistic Dummy data per Entity
* Calculations which can be performed within the database:
    * Potential Income of each host for each showcased property with available periods
    * Calculating Total Earnings of each host per month
* Search Feature function (Filtering) in finding properties by each guest based on their personal preferences

**For a clear look, the dummy data of each entity which are written in the "myAirbnb_Datamart.sql" script file are hosted on this Repository under the Dummy Data (Test Data) folder. There is also a metadata file hosted in this Repository for the database-specific information.

### Prerequisites in Opening Database
* A MySQL or MariaDB server must be installed on your machine or a server accessible to you.
* Please make sure a MySQL client tool is also installed (Recommended: MySQL Workbench).
* Please download the "myAirbnb_Datamart.sql" script file containing the database schema and dummy data hosted in this Github Repository.

### Installation and Importing Database Steps:
* Step 1: Download and Install MySQL Community Server from [here](https://dev.mysql.com/downloads/mysql/). Follow the MySQL Server installation instructions provided for your operating system.

* Step 2: Configure MySQL Server. During the installation, set a root password for MySQL Server. Remember this password as it will be needed later.

* Step 3: Download and Install MySQL Client tool (Recommended: MySQL Workbench) for managing the database from [here](https://dev.mysql.com/downloads/workbench/).

* Step 4: Connect to MySQL Server. Open your MySQL client tool (MySQL Workbench) and connect to the MySQL Server using the root credentials you set up during installation.

* Step 5: In your chosen MySQL client tool (MySQL Workbench), open the downloaded "myAirbnb_Datamart.sql" script file and execute it.

You have now successfully installed and imported the "myAirbnb_Datamart" database!

### Testing
As there is already dummy data included in the "myAirbnb_Datamart" database, after you have successfully installed and imported the "myAirbnb_Datamart" database, you are welcome to run the various test cases to test the functionality of this database. 
* All of these SQL script test cases are hosted in the Testcase folder of this GitHub Repository.
* Copy simply each test case script you want to follow and execute it in the MySQL Workbench.
* You are also welcome to create your own SQL test case script to test this database functionality.

**Please make sure the "myAirbnb_Datamart.sql" script file was already executed before running any test cases. 

### Contributing
Contributions are welcome! Please open an issue or pull request for any bugs, feature requests, or other feedback. This is my first SQL project and I appreciate all of your feedback.

### License
This program is free for personal use only. It is part of a university project for a B.Sc. degree and should not be used for commercial purposes. For educational uses, please include my name in the credits.



