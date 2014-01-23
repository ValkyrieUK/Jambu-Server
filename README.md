Invite Project Server
=======================

##
Curl Requests  
An example of a valid request.

```
curl http://localhost:3000/api/v1/users/3
```
```
curl -X DELETE http://localhost:3000/api/v1/users/4
```
Will return you a user with a record ID of 3

##If the DB isnt working in development try this in a shell

```
export PGHOST=localhost
```
