node {
    def tomcatWeb = '/opt/tomcat/webapps'
    def tomcatBin = '/opt/tomcat/bin'
    
    stage('SCM Checkout') {
        git 'https://github.com/rameshdadi78/JenkinsWar.git'
    }
    
    stage('Compile-Package-create-war-file') {
        def mvnHome = tool name: 'maven-3.8.7', type: 'maven'
        sh "${mvnHome}/bin/mvn package"
    }
    
    stage('Stop Tomcat Server') {
        sh """
        if pgrep -f 'tomcat' > /dev/null; then
            echo 'Tomcat is running. Stopping Tomcat...'
            sudo /opt/tomcat/bin/shutdown.sh
            sleep 10
        else
            echo 'Tomcat is not running.'
        fi
        """
    }
    
    stage('Deploy to Tomcat') {
        sh "cp target/JenkinsWar.war ${tomcatWeb}/JenkinsWar.war"
    }
    
    stage('Start Tomcat Server') {
        sh "${tomcatBin}/startup.sh"
        sleep time: 5, unit: 'SECONDS'
    }
}
