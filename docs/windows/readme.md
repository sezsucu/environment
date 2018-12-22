# Windows 10

## Install Windows Subsystem for Linux
Go to **Settings** and search for **Windows Features** and select **Turn Windows features on or off**.
From there select ***Windows Subsystem for Linux***. Then go to Microsoft Store and install Ubuntu
or any other linux you want. Search Linux to see the full list of apps available.

## Install VirtualBox
Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
Next download [Ubuntu ISO](https://www.ubuntu.com/desktop).
Create a virtual machine, and the first time it asks you the start-up disk. Select
the Ubuntu ISO you downloaded. If you skipped this question, then after starting
the machine you can go to **Machine** menu and select **Settings**. Select **Storage**
and choose the CD/DVD drive there and then **Choose Virtual Optical Disk Drive** and
choose the Ubuntu ISO and start the machine again.

## Programs to install
* [Chrome](https://www.google.com/chrome/)
* [git](https://git-scm.com/).
* [python](https://www.python.org/downloads/windows/)
* [JRE](https://www.java.com/en/download/)
* [JDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html)
* [Intellij IDEA](https://www.jetbrains.com/idea/download/#section=windows)
* [Visual Studio Code](https://code.visualstudio.com/download)
* [Ant](https://ant.apache.org/bindownload.cgi) See [Ant Installation](https://www.mkyong.com/ant/how-to-install-apache-ant-on-windows/)
* [Maven](https://maven.apache.org/download.cgi) See [Maven Installation](https://www.mkyong.com/maven/how-to-install-maven-in-windows/)
* [Microsoft Office](http://www.microsofthup.com/hupus/home.aspx)
* [Node.js](https://nodejs.org/en/)

## Cygwin
Install [Cygwin](https://cygwin.com/install.html). Make sure the following packages are
installed:

* emacs
* curl
* openssl
* unzip (Info-Zip)
* zip (Info-Zip)
* g++
* procps-ng (top, uptime, w etc...)
* tmux
* python-pip (pip2.7 install --upgrade pip)
* bc (calculator)

## Java
* [Set the JAVA_HOME](https://docs.oracle.com/cd/E19182-01/820-7851/inst_cli_jdk_javahome_t/)

## Environment Variables
* **JAVA_HOME** `C:\Program Files\Java\jdk-11.0.1`
* **ANT_HOME** `C:\Users\YOUR_USER_NAME\apache-ant-1.10.5`
* **PATH** `C:\Program Files\Java\jdk-11.0.1\bin`, `%ANT_HOME%\bin`,
`C:\Users\YOUR_USER_NAME\apache-maven-3.6.0\bin`

