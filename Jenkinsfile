node {
    def tomcatWeb = '/opt/tomcat/webapps'
    def tomcatBin = '/opt/tomcat/bin'
    
    stage('SCM Checkout') {
        git 'https://github.com/sivajavatechie/JenkinsWar.git'
    }
    
    stage('Compile-Package-create-war-file') {
        // Get Maven home path
        def mvnHome = tool name: 'maven-3.9.9', type: 'maven'
        sh "${mvnHome}/bin/mvn package"
    }
    
    stage('Stop Tomcat Server') {
        // Stop Tomcat server as the Tomcat user
        sh """
        if pgrep -f 'tomcat' > /dev/null; then
            echo 'Tomcat is running. Stopping Tomcat...'
            sudo -u tomcat ${tomcatBin}/shutdown.sh
            sleep 10
        else
            echo 'Tomcat is not running.'
        fi
        """
    }
    
    stage('Deploy to Tomcat') {
        // Ensure the .ssh directory and known_hosts file exist
        sh '''
        mkdir -p /var/lib/jenkins/.ssh
        touch /var/lib/jenkins/.ssh/known_hosts
        chmod 700 /var/lib/jenkins/.ssh
        chmod 600 /var/lib/jenkins/.ssh/known_hosts
        '''

        // Add the remote server's SSH key to known_hosts
        sh 'ssh-keyscan -H 192.168.0.112 >> /var/lib/jenkins/.ssh/known_hosts'

        // Deploy the WAR file
        sh 'scp -i /var/lib/jenkins/.ssh/id_rsa target/JenkinsWar.war manager@192.168.0.112:/opt/tomcat/webapps/JenkinsWar.war'
    }
    
    stage('Start Tomcat Server') {
        // Start Tomcat server
        sh "sudo -u tomcat ${tomcatBin}/startup.sh"
        sleep time: 5, unit: 'SECONDS'
    }
}
