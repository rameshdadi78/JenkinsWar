node {
    def tomcatWeb = '/opt/tomcat/webapps'
    def tomcatBin = '/opt/tomcat/bin'
    def tomcatStatus = ''
    
    stage('SCM Checkout') {
        git 'https://github.com/sivajavatechie/JenkinsWar.git'
    }
    
    stage('Compile-Package-create-war-file') {
        // Get Maven home path
        def mvnHome = tool name: 'maven-3.9.9', type: 'maven'
        sh "${mvnHome}/bin/mvn package"
    }
    
    stage('Stop Tomcat Server') {
        // Check if Tomcat is running and stop it if necessary
        sh """
        if pgrep -f 'tomcat' > /dev/null; then
            echo 'Tomcat is running. Stopping Tomcat...'
           sh "$sudo {tomcatBin}/shutdown.sh"
            sleep 10
        else
            echo 'Tomcat is not running.'
        fi
        """
    }
    
    stage('Deploy to Tomcat') {
        // Check if the WAR file exists before attempting to deploy
        sh 'ls -l target/'
        sh 'ls -l target/JenkinsWar.war'
        sh "scp target/JenkinsWar.war manager@<your-linux-server>:${tomcatWeb}/JenkinsWar.war"
    }
    
    stage('Start Tomcat Server') {
        sleep time: 5, unit: 'SECONDS'
        sh "${tomcatBin}/startup.sh"
        sleep time: 100, unit: 'SECONDS'
    }
}
