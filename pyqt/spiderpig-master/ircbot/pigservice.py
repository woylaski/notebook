#! /usr/bin/env python
# -*- coding: utf-8 -*-

import sys, re, os, subprocess, random, traceback



aliases = ['pig', 'piggy', 'mrpig', 'spiderpig', 'spider']

# ------------------------------------ The command registry API -------------------


# A pig service that answers a question. All members must exist and be non-empty
# This class should be implemented by all services provided by Spiderpig
class Service:
    name = 0                    # The name of the command, should be just one word, no spaces
    help = 0                    # Examples and syntax
    regexp = 0                  # The regular expression object
    #fn_action(question) = 0    # The fuction to call if the question matches the regexp. Must return string with answer (may be several lines)
    hidden = False              # Whether or not command should be displayed on help list (all useful commands should be shown, just for fun commands)


# Contains registered services for spiderpig
# Allows us to query which services exist, and help for each service
class ServiceRegister:

    services = {}

    def register(self, service):
        if self.validate(service):
            self.services[service.name.lower()] = service

    def validate(self, service):        
        valid = (hasattr(service, "name")  and hasattr(service, "help") and hasattr(service, "regexp") and hasattr(service, "fn_action"))
        if (not valid):
            print "Service '{0}' was not valid, and was not installed".format(service.name)
        return valid

    def getTheAnswer(self, question):

        for key, service in self.services.iteritems():
            if service.regexp.match(question):
                try:
                    answer = service.fn_action(question)
                    return answer
                except:
                    answer = "Problems answering '{0}': \n{1}".format(question, traceback.format_exc())
                    return answer

        return "Spiderpig is not that smart. Ask 'help' for a list of commands'"

# end class ServiceRegister


registry = ServiceRegister()

# must be set by calling script to allow callbacks for irc specific actions
spiderPigCallback = 0


# ------------------------------------ Short hand function -------------------

def make_regexp(expression):
    return re.compile(expression, re.IGNORECASE)

def register(name, help, regexpAsString, answer, hidden=False):
    s = Service()
    s.name = name
    s.help = help
    s.hidden = hidden
    s.regexp = make_regexp(regexpAsString)
    def action(question):
        return answer
    s.fn_action = action
    registry.register(s)


# ----------------------------------------------------------------------------
# DEFINE ALL SERVICES PROVIDED BY SPIDERPIG
# ----------------------------------------------------------------------------


# -------------------------- Auto ops ----------------------------------------

def give_ops(question):
    if not spiderPigCallback:
        print "Spiderpig callback not defined"
        return

    spiderPigCallback.give_ops_to_all()
    #for chname, chobj in spiderPigCallback.ircServerConnection.channels.items():
        #users = chobj.users()
        #for user in users:
            #cmd = "MODE %s +o %s" % (chname, user)
            #print cmd
            ##spiderPigCallback.ircServerConnection.send_raw(cmd)

    return "Ops given to all users. Act like a pig.\n---Your truly, Spiderpig"

autoops             = Service()
autoops.regexp      = make_regexp(r"auto-?ops?")
autoops.fn_action   = give_ops
autoops.name        = "autoop"
autoops.help        = "Syntax: auto-op(s) or autoop(s). Give ops to all users on channel"
registry.register(autoops)


# ---------------------------- Bus schedules ---------------------------------------
from services import trafikanten
def busAction(question):
    return trafikanten.busesToOsloString()

bus             = Service()
bus.regexp      = make_regexp(r".*bus.*")
bus.fn_action   = busAction
bus.name        = "Buses"
bus.help        = u"Syntax: Next buses? Or just 'bus'. \n\nThanks to P. Drivklepp for Trafikanten scripts."
registry.register(bus)


# ---------------------------- Road traffic ---------------------------------------
from services import traffic
def trafficQuestion(question):
    return traffic.getE18String()

trafficS             = Service()
trafficS.regexp      = make_regexp(r"how\'?s traffic")
trafficS.fn_action   = trafficQuestion
trafficS.name        = "Traffic"
trafficS.help        = u"Realtime traffic info for E18 from Soerenga to Asker. Syntax: How's traffic"
registry.register(trafficS)


# ---------------------------- Booty call ---------------------------------------
from services import bootycall
def bootyMsg(question):
    return bootycall.getRandomQuote()

booty           = Service()
booty.regexp    = make_regexp(r"booty *call")
booty.fn_action = bootyMsg
booty.name      = "BootyCall"
booty.help      = u"Random booty call message. Syntax: booty call"
registry.register(booty)


# ---------------------------- Stop service ---------------------------------------
def stopFunc(question):
    if (spiderPigCallback):
        spiderPigCallback.stop()
    return "Stopped spiderpig bog"

stop            = Service()
stop.regexp     = make_regexp(r"stop")
stop.fn_action  = stopFunc
stop.name       = "Stop"
stop.help       = u"Stop the bot"
registry.register(stop)

# ---------------------------- Who---------------------------------------
myName = "I am Spiderpig, son of Spiderbot, born 11.11.11. \nI also answer to theses names: " + ', '.join(aliases)
register("Who", "Tells basic info about Spiderpig. Syntax: Who are you.", r".*who.*",  myName)


# ---------------------------- Where ---------------------------------------
where = "I was last seen in a dirty pig sty @ Earth > Europe > Norway > Lysaker > PP20 > 410 > Stegosaurus"
where  = where + "\nI also hang around in svn://svn/system/trunk/main/functional/gui/tools/ircscripts/spiderpig"
register("Where", "Get the geographical and svn location of SpiderPig. Syntax: Where are you?", r".*where.*you.*", where)

# ---------------------------- Old ---------------------------------------
register("Age", "How old is SpiderPig. Syntax: How old are you?", r".*how.*old.*you.*", "I was born 11.11.11. Actually Python won't help me to calculate my age. So it's a challenge for you")

# ---------------------------- Meaning life---------------------------------------
register("MeaningLife", "Meaning of life. Syntax: Meaning of life", r".*meanin.*life.*", "Bacon", True)


# ---------------------------- Oink ---------------------------------------
register("Oink", "Oink is the ping signal of SpiderPig. Should return oink oink", r"oink", "Oink oink!")


# ---------------------------- Kick---------------------------------------
register("Kick", "Kicks the pig. Only evil people uses this", r"kick", "What kind of monster would kick a poor defenseless pig?")


# ---------------------------- What are you doing ---------------------------------------
doing = """Spiderpig Spiderpig
Does whatever a spiderpig does!
Can he swing from a web
No he can't
He's a pig
Look out
He's the spider pig"""
register("What", "Introduction of Spiderpig, a la Homer.", "What can you do?", r".*what.*do.*", doing)


# ------------------------------ Latest revs ---------------------------------
revs = Service()
from services import svn
revs.name = "LatestRevs"
revs.help = "Show your latest revisions. Syntax: Latest revs by <svn-username>"
revs.regexp = make_regexp(r"latest revs by \w+")
revs.fn_action = svn.latest_revs
registry.register(revs)

# ------------------------------ Uptime ---------------------------------
def measureUptime(question):
    timeStr = "Don't know when I got up, and don't know when I'm going to bed"
    if spiderPigCallback:
        t = spiderPigCallback.startTime.strftime("%Y-%m-%d %H:%M:%S")
        timeStr = "Been up and about since " + t
    return timeStr

uptime = Service()
uptime.name = "Uptime"
uptime.help = "Show when pig got out of bed. Syntax: uptime"
uptime.regexp = make_regexp(r"uptime")
uptime.fn_action = measureUptime
registry.register(uptime)

# ------------------------------ Reload ---------------------------------
def reloadPlugins(question):
    res = "Not able to reload plugins"
    if spiderPigCallback:
        spiderPigCallback.loadPlugins()
        res = "Plugins reloaded"
    return res
reloadPig = Service()
reloadPig.name = "Reload"
reloadPig.help = "Reload pig services (after code changes etc)"
reloadPig.regexp = make_regexp(r"reload")
reloadPig.fn_action = reloadPlugins
registry.register(reloadPig)

# ---------------------------- Help ---------------------------------------

from services import help
help.registry   = registry

help2            = Service()
help2.name       = "Help"
help2.help       = "Help, or help <command> for more info and syntax for a specific command"
help2.fn_action  = help.help_commands
help2.regexp     = make_regexp(r"(-)*help.*")
registry.register(help2)


# ----------------------------------------------------------------------------
# For testing. Use during developement of new service
# ----------------------------------------------------------------------------
def usage():
    print "Spiderpig bot. Answers all your dirty questions."
    print 'Test usage syntax: '
    print '    %s "Your question"' % sys.argv[0]

def main():
    if len(sys.argv) < 2:
        usage()
        sys.exit(1)

    question = sys.argv[1]
    answer = registry.getTheAnswer(question)
    print answer

if __name__ == "__main__":
    main()


#def latest_revs():
    #cmdtxt = "svn -l 20 log svn://svn/system/trunk/main/functional/gui/touchmenucharlie"
    #cmd = cmdtxt.split()
    #try:
        #output = subprocess.check_output(cmd)
    #except CalledProcessError:
        #output = "SVN error for: {}".match(cmdtxt)
    #except:
        #output = "Unknown error for: {}".match(cmdtxt)
    #return output




