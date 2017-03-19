# picoJournal.Application.Delphi
Windows based picoJournal client written in Delphi

picoJournal is the tiny journaling app for people short on time

This tool prompts the user with a couple of quick, random questions about their day. Users write out a short response which is saved to the database and can be reviewed at a future date.

The goal is to have fun, offer positive reinforcement, and maybe learn a thing or two while developing 😊

The application can connect either directly to the application database, or use a Web API to persist data. To use the Web API, check out picoJournal.net at https://github.com/thebatdan/picoJournal.net.

## Future ideas
- Mobile clients
- Sharing to Facebook, Twitter, etc.
- Maybe a web API in Azure, if I'm feeling adventurous

## About the Database
At the moment, picoJournal uses an SQL Server Express database MDF file. This file is included in the repository. For now, the easiest way to get the database up and running is to connect the database using Visual Studio. 

### Instructions for connecting the database in Visual Studio 2017
- On the Tools menu, select 'Connect to a Database...'
- Select Microsoft SQL Server as the data source
- Enter Server Name as '(localdb)\mssqllocaldb'
- Select 'Attach a database file'
- Browse to picoJournal database location and select picoJournal.mdf
- Enter picoJournal as the Logical Name
- Test the connection, and click Ok to save.
