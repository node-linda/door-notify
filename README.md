Linda Door Notify
=================
notify [door-open](https://github.com/node-linda/node-linda-door-open-delta) value to [skype](https://github.com/node-linda/ruby-linda-skype) and [mac-say](https://github.com/node-linda/node-linda-mac-say)


- watch {"type": "door", "cmd": "open", "result": "success"}
  - write {"type": "skype", "cmd": "post", "value": "#{space}でドアが開きました"}

- https://github.com/node-linda/door-notify


## Install Dependencies

    % npm install


## Run

    % npm start


## Install as Service

    % gem install foreman

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app node-linda-door-notify -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/node-linda-door-notify-main-1.plist

for upstart (Ubuntu)

    % sudo foreman export upstart /etc/init/ --app node-linda-door-notify -d `pwd` -u `whoami`
    % sudo service node-linda-door-notify start
