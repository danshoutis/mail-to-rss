email-to-rss
============

This is a simple script that downloads unread emails from IMAP
folder(s) and converts them into an RSS feed.

I wrote it to move mailing list traffic out of my gmail and into
google reader.

Dependencies
============

* fetchmail  (http://fetchmail.berlios.de/)

* MHonArc (http://www.mhonarc.org/)

Setup
=====

* fetchmail needs to be on your path.

* `config.system` needs to point at MHonArc (it doesn't need to be installed system-wide)

* Optionally, edit HTMLPATH to point at the folder where you want output RSS+HTML to live. (I use a public Dropbox folder for maximum convenience.)

* Edit `config.user.example` with your account details and save it as `config.user`

* Set it up to run automatically.