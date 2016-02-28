#! /usr/bin/env python

import spiderpig
import argparse

#irclib.DEBUG = 0

def startPig(server, port, channel, nick):
    print "Connecting to {0} {1} {2} as {3}".format(server, port, channel, nick, username=nick, ircname=nick)
    bot = spiderpig.SpiderPig( [(server, port)], nick, channel)
    bot.start()


def main():

    parser = argparse.ArgumentParser(description='Start spiderpig irc bot')

    parser.add_argument('-s', dest='server',  default='irc.rd.tandberg.com')
    parser.add_argument('-p', dest='port',    default= 6667)
    parser.add_argument('-c', dest='channel', default='#spider')
    parser.add_argument('-n', dest='nick',    default='spiderpig')

    args = parser.parse_args()

    startPig(args.server, args.port, args.channel, args.nick)

if (__name__ == "__main__"):
    main()
