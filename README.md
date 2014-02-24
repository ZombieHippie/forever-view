forever-view
============

Nodejs MakeMKV robot also a nodemailer example


This is used to autonomously rip movies using [MakeMKV](http://www.makemkv.com/developers/)
then compress them with [HandBrake](http://handbrake.fr/)

With nodejs, it runs child processes and monitors the `std.out` stream.

After the disc is processed, the nodemailer sends you an email.
