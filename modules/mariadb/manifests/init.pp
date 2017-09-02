# Add our new class for MariaDB
class mariadb (
	$path = '/vagrant/extensions/mariadb',
) {

	apt::source { 'mariadb':
		location => 'http://mirror.aarnet.edu.au/pub/MariaDB/repo/10.2/ubuntu',
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
	class { '::mysql::server':
		package_name     => 'mariadb-server',
		package_ensure   => 'latest',
		service_name     => 'mysql',
		root_password    => 'password',
		override_options => {
			mysqld      => {
				'log-error' => '/var/log/mysql/mariadb.log',
				'pid-file'  => '/var/run/mysqld/mysqld.pid',
			},
			mysqld_safe => {
				'log-error' => '/var/log/mysql/mariadb.log',
			},
		}
	}

	Apt::Source['mariadb'] ~> Class['apt::update'] -> Class['::mysql::server']
}
