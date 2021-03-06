
class swftools {
	$swftools = "http://www.swftools.org/swftools-2013-04-09-1007.tar.gz"

	exec { "retrieve swftools":
		command => "wget -q ${swftools} -O ${download_path}/swftools.tar.gz",
		path => "/usr/bin",
		creates => "${download_path}/swftools.tar.gz",
	}


	package { "tar":
		ensure => present,
	}

	exec { "unpack swftools":
		command => "tar xzf ${download_path}/swftools.tar.gz",
		path => "/bin:/usr/bin",
		cwd => "/tmp",
		require => [ Package["tar"], Exec["retrieve swftools"], ],
	    	unless => "test -d /tmp/swftools-2013-04-09-1007",
	}

    exec { "build swftools":
        require => [ 
		Exec["unpack swftools"], 
		Package["build-essential"],
		Package["g++"],
		Package["libgif-dev"],
		Package["libjpeg62-dev"],
		Package["libfreetype6-dev"],
		Package["libpng12-dev"],
		Package["libt1-dev"],
		],
        command => "./configure && make && make install",
        path => "/bin:/usr/bin",
        cwd => "/tmp/swftools-2013-04-09-1007",
        provider => "shell",
	unless => "test -x /usr/local/bin/pdf2swf",

    }


#   sudo apt-get $APTVERBOSITY install make build-essential ccache g++ libgif-dev libjpeg62-dev libfreetype6-dev libpng12-dev libt1-dev
	package { "build-essential":
		ensure => present,
	}
	package { "ccache":
		ensure => present,
	}	
	package { "g++":
		ensure => present,
	}
	package { "libgif-dev":
		ensure => present,
	}
	package { "libjpeg62-dev":
		ensure => present,
	}
	package { "libfreetype6-dev":
		ensure => present,
	}
	package { "libpng12-dev":
		ensure => present,
	}
	package { "libt1-dev":
		ensure => present,
	}

}
