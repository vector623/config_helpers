# Make + powershell = reliable build automation

Following 12factor practices, I want to keep sensitive creds out of git and store them in environment variables (in 
reality, they are checked into git, but encrypted via StackExchange's excellent 
[blackbox][1] project).

I then generate scripts to load the creds into windows environment variables (via a batch script) and/or linux 
environment variables (since most of my development currently is on .Net Core).  To deploy, I also like to generate 
systemd service files, which ought to contain the necessary environment variables as well.

I prefer to use Makefiles to help automate building these configs (along w/the rest of the project, and with 
deployment).  However, string manipulation with bash is a real pain.  So I've opted to use powershell, which I've found
to be much more reliable at handling and manipulating text.  

Bash has caused so many problems when it comes to string quoting and special characters.  What took hours of effort and 
ultimately resulted in failure to write a robust bash script to generate systemd files w/the environment variables 
loaded took less than an hour in powershell, WITH PRACTICALLY NO PRIOR POWERSHELL EXPERIENCE.  I will add that I've got
a lot of .Net development experience, which was sped up my powershell development quite nicesly.

## requirements
[Powershell for linux][2] is required.  

The makefile must also be run in linux (if you're on windows, use the [windows linux subsystem][3]).

## generate configs
run `make config` to read in `environment_variables.sh` and `systemd.service.template` and generate both 
`environment_variables.bat` and `systemd.service`

run `make clean` to delete the generated files

## notes
Powershell has multiple syntax flavors. `generate_environment_variables_batchfile.ps1` will probably look more familiar 
to .Net developers, while `generate_environment_variables_batchfilev2.ps1` is probably the more common way to do the 
same job

`generate_environment_variables_batchfilev3.ps1` is a further refined version of the batch file generator


[1]: https://github.com/StackExchange/blackbox
[2]: https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-powershell-core-on-macos-and-linux 
[3]: https://docs.microsoft.com/en-us/windows/wsl/install-win10
