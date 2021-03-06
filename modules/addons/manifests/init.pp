
class addons {

	include "addons-jsconsole"
	include "addons-content-stores"
	include "addons-datalist-ext"
	
	include "addons-zaizi-alfresco-recommendations"
	include "addons-support-tools"

######################################################################################################


	# copy alfresco bin files to the alfresco base dir
	file { "${alfresco_base_dir}/bin":
		ensure => directory,
		recurse => true,
		source => "${alfresco_unpacked}/bin",
		require => Exec["unzip-alfresco-ce"], # TODO crossdep
	}

	exec { "apply-addons":
		require => [
			File["${alfresco_base_dir}/bin/apply_amps.sh"],
			Exec["unpack-tomcat7"], # TODO CROSSDEP!
		],
		before => [ Service["tomcat7"], ], # TODO CROSSDEP!
		path => "/bin:/usr/bin",
		command => "${alfresco_base_dir}/bin/apply_amps.sh",
		notify => Exec["fix-war-permissions"],
		#logoutp
	}

	file { "${alfresco_base_dir}/bin/apply_amps.sh":
		ensure => present,
		mode => "0755",
		content => template("alfresco-common/apply_amps.sh.erb"),
		require => File["${alfresco_base_dir}/bin"],
	}


	exec { "fix-war-permissions":
		path => "/bin",
		command => "chown tomcat7 ${tomcat_home}/webapps/*.war; chmod a+r ${tomcat_home}/webapps/*.war",

	}
}
