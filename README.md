A website for displaying information and advertisements "PRs". Created with Python using flask. 
## Usage
- ```/``` displays PRs.
- ```/admin``` is the administrator interface for managing PRs. Can be accessed by any registered user. Users with the ```admin``` role will be able to manage all PRs while users with the ```pr``` role will only be able to access their own.
- ```/admin/users``` is the user management interface, available only for users with the ```admin``` role.
- ```/pr``` returns a list of relative links to PRs to be shown in JSON format.

### Dates
A day starts at 5:00 and ends at 5:00 the next day. This means that an end date ```%yy-%mm-%dd``` translates to ```%yy-%mm%dd+1 5:00```. The time of start dates is also set to 5:00, except for when the start day is the current day. In this case the time is set to the current time and the PR is displayed immediately. PRs are permanently removed after their end date (as soon as ```/pr``` is requested).

### Priority
The default priority is 0. If a PR has its priority set to 1, it will be the only PR shown until its end date (useful for pubs etc.).

### Migrations
In order to enable changes to the database schema there is the `src/migrations` folder, files in this folder named like `07-myname.py` (<number>-<name>.py) are migrations which are used to migrate to new database schemas.

Files in the migrations folder should define a function `upgrade()` which updates from the previous schema to the new one. Please thoroughly test that your migration works properly locally before pushing any remote changes.

Concretely, when you make changes to `src/data.py`, you must also create a new migration, with number following the last existing one, which runs database operations migrating from the old format to the new one.

The database tracks its current migration version and runs all new migrations on application startup.

## Running locally
In order to aid running locally there is a shell script `dev.sh`, running `./dev.sh setup` sets up a python virtualenv with all the dependencies, running `./dev.sh run` will run the application on port `8080`, running `./dev.sh shell` will run bash with the virtual env tools in path.

## Running in Docker
The provided sample compose file should work out of the box provided a
`SECRET_KEY` env-variable. Additional variables can be found in `src/config.py`.

At first launch the database is populated with a user _admin_ with the password
_pass_. It is suggested you change this immediately.
