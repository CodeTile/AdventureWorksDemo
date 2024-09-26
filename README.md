# AdventureWorksDemo
Demo of a system connecting to the Microsofts demo database AdventureWorks.  
This project will provide a Restful API to connect to the database along with tests.  
This project is meant as a proving ground for ideas and as a reminder of how to implement clean code/ design practices etc...  
  
I will inevitably get some of these ideas wrong, so please point me in the right direction.  

While I am concentrating on getting the basics in place, then I am foccusing on the ProductCategory table.

## Setup (API)
To run the API you need an instance of MS-SQL running AdventureWorks database.
Follow the steps below to restore the database to a MS-SQL docker image.  
1. Start Docker Desktop if needed.
2. Run the script ``` ...\AdventureWorksDemo\Configuration\CreateDockerAdventureWorks.sh ```  
3. Follow the instructions in the scipt output to restore the database.  

## Testing
#### Standard TDD testing
For standard TDD testing this project will use nUnit.  
#### Integration testing
For integration testing this project will use the SpecFlow replacment [reqnroll](https://reqnroll.net/).  

It will also require a database and access to a MS-SQL database with a backup file that can be accessed by both the project and the database.  
This should automaticaly download to docker desktop and an image created.


## Project status  
I am still working on the basics for this project, as such I am concentrating on the table [ProductCategory]. The reason for this table is it depends on no other objects, which makes getting the basics right easier.  
Outstanding issues can be found on [github](https://github.com/CodeTile/AdventureWorksDemo/issues)


## References  
A list of various references that I have found usefull when working on this project.
https://www.continuousimprover.com/2023/03/docker-in-tests.html
 
