#!/bin/bash
# Hotfix for gitpod not being able to open the preview consistently via gp preview $(gp url <port>)
msg="\e[38;5;208mGitpod was not able to open the preview.\e[0m
You may open the preview by running the command:\e[38;5;183m op\e[0m
You may also pass in an additional path to open such as:\e[38;5;183m op hello_world\e[0m"
echo -e "$msg"