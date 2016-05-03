getVolunteers
=============

Enables you to show on any website if you need volunteers right now.

Example use case
----------------

Imagine a recurring event that is dependant on volunteers. You have a website 
but no easy way to let people know if you need more help or if you are fine.

With this service you can embed an image into your website. The image will 
look different depending on the number of assigned volunteers. For example 
it could say 'Mentors needed' or 'Mentors found'. If someone clicks on the 
image a new site will open where the user can sign up as new volunteer.

State
-----

Basic functionality is implemented. There are some limitations:

 - A sign up for an event directly increases the volunteer counter. There is no 
   required email confirmation yet.
 - Only the administrator can remove volunteers from an event.
 - The event status image will always call the volunteer a 'mentor'.

Demo
----

The latest version is available on 
[getvolunteers.net](http://getvolunteers.net/test).

Setup
-----

Run getVolunteers locally:

    git clone git@github.com:RmMsr/getVolunteers.git
    cd getVolunteers
    bundle install
    bundle exec rake dm:setup
    bin/get-volunteers
    # Browse to http://localhost:3000/

Run as docker container:

    docker pull rmmsr/get-volunteers
    docker run --name get-volunteers -p 3000:80 rmmsr/get-volunteers
    docker exec -it get-volunteers bundle exec rake dm:setup
    # Browse to http://YOUR-DOCKER-HOST:3000/

Please note: If you use the default setup, the sqlite database runs inside the 
docker container and data will be lost once the container removed.

License
-------

This is free and open software. See [unlicense.org](http://unlicense.org/) for details.
