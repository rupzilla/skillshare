Mac Users:
 
        Install Ruby
 
1.     Ruby comes preinstalled on OS X 10.5+ and included are the developer tools
2.     Use the command “gem update rails” to get the latest version
 
Install RubyGems
 
1.     If you do not have RubyGems:
a.     Go to http://rubygems.org/pages/download
b.     Download the latest version by selecting one of the download options
2.     If you already have RubyGems:
a.     To get the latest Ruby Gems use the “gem update --system”    command
b.     You may need to be in the administrator or root directory
 
Install Rails
 
1.     After RubyGems are loaded you can install Rails by using the “gem install rails” command
 
Install GitBash
 
1.     Go to https://code.google.com/p/msysgit/downloads/list?q=label:Featured
2.     Download the file that starts with “Git-“
 
Run the Application
        
1.     Create an empty folder on your desktop
2.     Run GitBash
3.      Type “cd Desktop/(folder name)
4.     Git pull https://github.com/rupzilla/skillshare.git
5.     Type “bundle install”
6.     Type “rake db:migrate”
7.     Type “rake db:populate”
8.     Type “rails s”
9.     Go to your browser and navigate to http://localhost:3000
 
 

 

Windows:
 
Install Ruby
 
1.     Go to http://rubyforge.org/projects/rubyinstaller/
2.     Download the “RubyInstaller”
3.     Download the “Development Kit”
 
Install RubyGems
 
1.     If you do not have RubyGems:
a.     Go to http://rubygems.org/pages/download
b.     Download the latest version by selecting one of the download options
2.     If you already have RubyGems:
a.     To get the latest Ruby Gems use the “gem update --system” command
b.     You may need to be in the administrator or root directory
 
Install Rails
 
1.     After RubyGems are loaded you can install Rails by using the “gem install rails” command
 
Install GitBash
 
1.     Go to https://code.google.com/p/msysgit/downloads/list?q=label:Featured
2.     Download the file that starts with “Git-“
 
Run the Application
        
1.     Create an empty folder on your desktop
2.     Run GitBash
3.      Type “cd Desktop/(folder name)
4.     Git pull https://github.com/rupzilla/skillshare.git
5.     Type “bundle install”
6.     Type “rake db:migrate”
7.     Type “rake db:populate”
8.     Type “rails s”
9.     Go to your browser and navigate to http://localhost:3000
 



-------------Running on a Windows Machine?-----------------
Most of Ruby on Rails developers have a problem to install therubyracer gem in windows environment.
The "therubyracer_for_windows" package provides all the necessary gems and v8.dll to solve this issue. 

Installation steps:

1. Download the package

2. Open the windows command prompt and brows the "therubyracer_windows\" directory

eg:- 

If you download the package in to c:\downloads\, then the path in command prompt should be "c:\downloads\therubyracer_windows\"
you can do it by typing "cd c:\downloads\therubyracer_windows\"

3. Install the ruby gem "therubyracer-0.11.0beta1-x86-mingw32.gem"

This can be done by typing gem install therubyracer-0.11.0beta1-x86-mingw32.gem
eg:-

c:\downloads\therubyracer_windows> gem install therubyracer-0.11.0beta1-x86-mingw32.gem

4. Copy v8.dll & v8preparser.dll in to ruby\bin folder


done...


Enjoy ruby developments more :-)