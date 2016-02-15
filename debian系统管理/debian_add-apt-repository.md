The add-apt-repository command is part of the software-properties-common package in Debian 8.x (jessie). Once you've installed software-properties-common, you'll have add-apt-repository available and you can use it to add PPA repositories.

Note: Be sure that the packages you're installing are compatible with Debian. If the packages are only available for Ubuntu and you need to install the package that is the "best match" to your Debian release, you'll need to adjust the appropriate repository entry, for example to change the release from jessie to utopic or vivid (by default, the repository will be added with the release name that matches your Debian release, as you'd expect).

For example

From:

deb http://ppa.launchpad.net/nemh/systemback/ubuntu jessie main 
deb-src http://ppa.launchpad.net/nemh/systemback/ubuntu jessie main
To:

deb http://ppa.launchpad.net/nemh/systemback/ubuntu vivid main 
deb-src http://ppa.launchpad.net/nemh/systemback/ubuntu vivid main