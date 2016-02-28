#!/usr/bin/env python

import pluginloader
import sys


class Service:

    supported_formats = ["text", "json", "html"]
    required_attributes = set(["name", "description", "canAnswerQuestion", "answerQuestion"])
    plugins = 0

    def __init__(self):
        self.plugins = self.get_plugins()

    def get_plugins(self):
        pluginpath = '.'
        return pluginloader.find_modules(pluginpath)

    def answerQuestion(self, question, format="text"):
        if not (format in self.supported_formats):
            print "Format {} not supported".format(format)
            return

        #print "Question <{0}> in format '{1}'".format(question, format)
        for plugin in self.plugins:
            #print "Asking", plugin
            if plugin.canAnswerQuestion(question):
                #print "<{}> answers:".format(plugin.name())
                answer = plugin.answerQuestion(question, format)
                return answer

        return "No answer found"

if __name__ == "__main__":

    service = Service()
    if len(sys.argv) < 2:
        plugins = service.get_plugins()
        print "Available plugins:"
        for p in plugins:
            print "*", p.name(), ":", p.description()[0:30], "..."

    else:
        question = sys.argv[1]
        format = "text"
        if len(sys.argv) > 2:
            format = sys.argv[2]
        answer = service.answerQuestion(question, format)
        print answer


