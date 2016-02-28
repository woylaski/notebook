
# This one must be set by caller before module can run
registry = 0;


def get_command(question):
    parts = question.split()
    cmd = ""
    if (len(parts) > 1):
        cmd = parts[1]
    return cmd

def help_commands(question):
    if (not registry):
        text = "Help not working. Unable to find registry"

    commandList= [cmd.name.lower() for key,cmd in registry.services.iteritems() if not cmd.hidden]
    commandList.sort()

    cmd = get_command(question).lower()
    if (cmd in commandList):
        help = registry.services[cmd].help
        return help

    commands = ', '.join(commandList)
    text = "Syntax: spiderpig: question \nAvailable commands: {0} \nType Help <command> for more details and syntax".format(commands)
    text = text + "\nYou can also use 'pig', 'piggy', 'mrpig', 'spiderpig' or 'spider' as nick"
    # TODO get the nicks programatically
    return text
