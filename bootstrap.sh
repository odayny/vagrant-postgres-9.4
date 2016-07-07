if [ ! -f /etc/apt/sources.list.d/pgdg.list ]
then
	echo "      ===== Adding postgresql repository to sources ====="
	wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
	sudo echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" >> pgdg.list
	sudo cp pgdg.list /etc/apt/sources.list.d/pgdg.list
fi

if [ ! -f ~/pg_installed ]
then
	echo "      ===== Installing postgresql ====="
	sudo apt-get update
	sudo apt-get -y install postgresql-9.5 postgresql-client-9.5
	touch ~/pg_installed
fi

if [ ! -f ~/pg_socket_patched ]
then
	echo "      ===== Patching pg_hba.conf ====="
	sudo printf "\nhost    all             all             127.0.0.1/32            trust\n" >> /etc/postgresql/9.5/main/pg_hba.conf
	sudo printf "\nhost    all             all             all                     md5\n" >> /etc/postgresql/9.5/main/pg_hba.conf
	sudo printf "\nlisten_addresses = '*'" >> /etc/postgresql/9.5/main/postgresql.conf
	sudo service postgresql restart
	touch ~/pg_socket_patched
fi

if [ ! -f ~/pg_password_reset ]
then
	echo "      ===== Changing pasword ====="
	sudo -u postgres psql postgres -c "ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres'"
	touch ~/pg_password_reset
fi
