# Add our new class for MariaDB
class mariadb (
	$path   = '/vagrant/extensions/mariadb',
	$config = sz_load_config()
) {

	include apt

	apt::source { 'mariadb':
		location => 'http://mirror.aarnet.edu.au/pub/MariaDB/repo/10.4/ubuntu/',
		release  => $::lsbdistcodename,
		repos    => 'main',
		key      => {
			id     => '177F4010FE56CA3336300305F1656F24C74CD1D8',
			server => 'hkp://keyserver.ubuntu.com:80',
		},
		include  => {
			src => false,
			deb => true,
		},
	}

	package { 'mariadb-server':
		ensure  => installed,
		require => [ Apt::Source['mariadb'], Class['mysql::server'] ]
	}
}

# Inherit the MySQL class and adjust it for MariaDB.
class mysql::mariadb inherits mysql {
	Class['mysql::server'] {
		package_name     => 'mariadb-server',
		package_ensure   => 'latest',
		service_name     => 'mysql',
		root_password    => $config['database']['password'],
		bindings_enable  => true,
		override_options => {
			mysqld      => {
				'log-error' => '/var/log/mysql/mariadb.log',
				'pid-file'  => '/var/run/mysqld/mysqld.pid',
			},
			mysqld_safe => {
				'log-error' => '/var/log/mysql/mariadb.log',
			},
		},
	}
}
