#!make

environment_variables.bat: environment_variables.sh
	./generate_environment_variables_batchfile.ps1 -environments_variables_file ./environment_variables.sh

systemd.service: environment_variables.sh systemd.service.template
	./generate_systemd_service_file.ps1 -environments_variables_file ./environment_variables.sh -systemd_template_file ./systemd.service.template

config: environment_variables.bat systemd.service

clean:
	-rm environment_variables.bat
	-rm systemd.service