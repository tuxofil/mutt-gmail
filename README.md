# Mutt-related configs for Gmail account

## Dependencies

* mutt-patched;
* offlineimap (>= 6.5.7);
* abook;
* catdoc;
* make.

## Changing to your needs

Examine configs carefully and replace John Doe with your
account requisites.

Do the first synchronization with ```make sync``` (it can take
a lot of time when your Gmail account keeps a lot of mail)
and see which folders were created under the ```Mail```
directory. Then specify all folders you want to see in the
Mutt's sidebar in the ```mailboxes``` configuration option
in the ```muttrc``` configuration file. The minimal folder
set is "MyInbox" (see below), "Drafts", "Sent Mail", "Spam"
and "Trash". Here you also can add any of your favorite labels.

## Running

```make ui``` will start the Mutt.

```make sync``` will start a single synchronization process.
The command is something that you can put into your crontab.

```make clean``` will remove all caches and logs BUT local
maildirs will not be affected. If you want to remove them
too do it by hand with ```rm -rf Mail```.

## Mutt navigation

Here are the main navigation key bindings:

* _Arrow Down_ - next folder;
* _Arrow Up_ - previous folder;
* _Arrow Right_ - select folder;
* _j_ - next message;
* _k_ - previous message.

## Gmail magic

The main goal is to provide message threads view like Gmail
web UI does.

"INBOX" IMAP folder is not good enough for the main mail folder
used in Mutt because sent mail is not appear in the folder
(but Gmail web UI shows it there). Because of this threads in
Mutt index consists only of received mail. You can "fix" it by
explicit save sent messages with "set record = +INBOX" but all
messages sent by web UI or mobile client will be not affected.
The second inconvinience is when you open web UI after sending
message with Mutt you will see your sent message twice in the
thread.

There is a special IMAP folder called "[Gmail]/All Mail". All
messages sent with Mutt, web UI or other clients will appear
in the folder automagically, BUT you can not remove any
messages from the folder! When you do so, offlineimap tool
will remove the messages on the remote side and everything
looks great until next synchronization which will bring all
"removed" messages back to the local folder. So the "All Mail"
folder does not fits our needs too.

I have fixed the thing creating an extra label in the Gmail
web UI (say, MyInbox). How it works:

1. All incoming mail moved to MyInbox with Gmail filter;
2. All outgoing mail labelled with "MyInbox" with another
 Gmail filter;
3. Mutt points to "MyInbox" IMAP folder as the main folder;

The only inconvinience is the Inbox will always be empty
when you visit your account with web UI or mobile client.
You should look to the MyInbox label instead to find your
mails.

All other aims are achieved:

* threads consists of all mails (received and sent) in all
 clients and without any duplication. Message sent from
 one client will be successfully displayed by any other
 clients;
* mails and threads can be easily removed in all clients.

## Gmail prerequisites

1. Login into the account;
2. Got to the settings page;
3. Set language to English (because actual label names are
 translated to the language);
4. Create "MyInbox" label;
5. Go to "Inbox" and add a filter which labels all incoming
 messages with "MyInbox". Set filter condition to "size
 is more than 1 byte";
6. Go to "Sent Mail" and add a filter which labels all
 sent messages with "MyInbox". Set filter condition to
 "size is more than 1 byte";
7. Mark all messages in "Inbox" and "Sent Mail" with "MyInbox"
 label.

## Notes

Actual IMAP folder names can differ from account to account.
I saw differences like "[Gmail]/Drafts" and "[Google Mail]/Drafts".

I have tested with offlineimap git-cloned from official
[https://github.com/OfflineIMAP/offlineimap](https://github.com/OfflineIMAP/offlineimap)
because it is too old in Debian. Installation is straightforward:

```sh
git clone https://github.com/OfflineIMAP/offlineimap /home/john.doe/bin/offlineimap
```

and set _OFFLINEIMAP_ variable in the Makefile to
``/home/john.doe/bin/offlineimap/offlineimap.py``.
