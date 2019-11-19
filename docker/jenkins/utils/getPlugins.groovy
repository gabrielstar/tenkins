//run this in http://jenkinsURL/script
Jenkins.instance.pluginManager.plugins.each{
    plugin ->
        println ("${plugin.getShortName()}")
}