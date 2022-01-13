Show a list of bookmarks

## User Stories
```
As a user
So that I can revisit website that I like
I can see the list of bookmarks

As a user
So that I can revisit website that I like
I can add bookmarks to the list

As a user
So I can remove my bookmark from Bookmark Manager
I want to delete a bookmark

```
 
Domain Model 

| Objects           | Messages  |
| -----------       | --------- |
| User              |           |
| List of Bookmarks | show_list |
| Bookmark          |           |


## How to Use

### Set up the project:
Clone this repo and run:
```
bundle
```

### Set up the databases:
Connect to `psql`.
Create the `bookmark_manager` and `bookmark_manager_test` databases. 
```
CREATE DATABASE bookmark_manager;
CREATE DATABASE bookmark_manager_test;
```
Set up the database tables – connect to each database in `psql` with `\c database_name`.
Run the SQL scrips in `db/migrations` in order. 

... tbc
