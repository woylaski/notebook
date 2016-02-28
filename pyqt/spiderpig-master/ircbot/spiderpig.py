#! /usr/bin/env python

import re
import irclib
import datetime
import pigservice
from ircbot import SingleServerIRCBot


class SpiderPig(SingleServerIRCBot):

    my_names = ['pig', 'piggy', 'mrpig', 'spiderpig', 'spider']
    channel = 0
    startTime = 0
    isRunning = 0

    def __init__(self, server_list, nickname, channel):
        SingleServerIRCBot.__init__(self, server_list, nickname, nickname)
        self.channel = channel

        # for all other possible events to handle, see irclib.py > numeric_events, generated_events
        # and protocol_events
        self.my_names.append(nickname)
        self.startTime = datetime.datetime.now()
        self.loadPlugins()

    # --------------------------- Event handlers -----------------------------

    def on_welcome(self, c, e):
        if (self.channel):
            c.join(self.channel)

    def loadPlugins(self):
        reload(pigservice)
        self.my_names = pigservice.aliases
        pigservice.spiderPigCallback = self

    def on_pubmsg(self, connection, event):
        msg = event.arguments()[0]
        sender = nm_to_n(event.source())
        channel = event.target()
        print "IRC public event"
        print "FROM:" + sender                            # FROM
        print "TO:  " + channel                           # TO (channel name or nick, if direct message)
        print "MSG: " + msg                               # MSG

        if (self.is_msg_for_me(msg)):
            question = self.remove_target(msg)
            answers = self.answer_question(sender, question).split("\n")
            answerFull = [ (sender + ": " + line) for line in answers]
            self.send_channel_msg(channel, u"\n".join(answerFull))
        else:
            print "Not for me"
        return 1

    def on_primsg(self, connection, event):
        msg = event.arguments()[0]
        sender = nm_to_n(event.source())
        me = event.target()
        print "IRC public event"
        print "FROM:" + sender                            # FROM
        print "TO:  " + me                                # TO (channel name or nick, if direct message)
        print "MSG: " + msg                               # MSG

        answer = self.answer_question(sender, msg)
        self.send_private_msg(sender, answer)
        return 1

    def on_kick(self, connection, event):
        if (self.channel):
            connection.join(self.channel)

    # override SimpleIRCClient.start() and IRC.process_forever to provide possibility to stop
    def start(self):
        print "Starting Spiderpig bot"
        timeout = 0.2
        self.isRunning = 1
        self._connect()
        while (self.isRunning):
            self.ircobj.process_once(timeout)
        print "SpiderPigBot: stopped"

    def stop(self):
        self.isRunning = 0

    # --------------------------- Helper func -----------------------------

    def give_ops_to_all(self):
        #print "Give ops: "
        for chname, chobj in self.channels.items():
            users = chobj.users()
            for user in users:
                cmd = "MODE %s +o %s" % (chname, user)
                #print cmd
                self.connection.send_raw(cmd)



    def is_msg_for_me(self, msg):
        recipient = msg.split(":")[0].strip()
        return (recipient and recipient in self.my_names)

    def answer_question(self, sender, question):
        ans = pigservice.registry.getTheAnswer(question)

        return ans

    def regexp(self, expression):
        return re.compile(expression, re.IGNORECASE)

    def remove_target(self, msg):
        text = msg.split(":")
        if len(text) > 1:
            return text[1].strip()
        else:
            return ""

    def send_private_msg(self, nick, msg):
        self.talk(nick, msg)

    def send_channel_msg(self, channel, msg):
        self.talk(channel, msg)

    def talk(self, recipient, msg):
        msg = msg.split("\n")
        for txt in msg:
            if (self.connection):
                if (txt):
                    self.connection.privmsg(recipient, txt)

# end class SpiderPig


# copied from irclib to avoid unnecessary dependency
def nm_to_n(s):
    """Get the nick part of a nickmask.

    (The source of an Event is a nickmask.)
    """
    return s.split("!")[0]

