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

## Running in Docker
The provided sample compose file should work out of the box provided a
`SECRET_KEY` env-variable. Aditional variables can be found in `src/config.py`.

At first launc the database is populated with a user _admin_ with the password
_pass_. It is suggested you change this immediately.
