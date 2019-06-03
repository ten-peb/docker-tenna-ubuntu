// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//
// Jenkinsfile defining a mini pipeline to build and stage a Docker image
// containing the following:
//    Ubuntu:18.04 LTS
//    Puppet Agent
//    Nagios NRPE server
//
// Author
//     Peter L. Berghold <pberghold@tenna.com>
//
// Copyright and License
//
//     This work is copyrighted (c) Copyright 2019, Tenna LLC all rights
//     reserved.
//
//     No derived works from this should be made without consulting the
//     author or a representative of Tenna LLC and without express permission.
//
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
node("master"){

  def String giturl = "git@github.com:ten-peb/docker-tenna-ubuntu.git"
  def String clone2 = 'tenna-ubuntu'
  def String image_base_tag = "tenna/ubuntu"
  def String image_version_tag = "18.0.4"

  // Grab the latest version from GitHub to "clone2" subdirectory to work on
  stage("checkout source"){
    doGitClone(giturl,clone2)
  }
  // Build the image
  stage("build image"){
    try {
      dir(clone2){
        def String image_tag = image_base_tag + ':' + image_version_tag;
        doDockerBuild(image_tag)

        doDockerBuild(image_base_tag + ':latest')
      }
   } catch(err) {
     currentBuild.result = 'FAILURE'
     String[]   message = [
     "I'm sorry to report a job has failed.",
     "${currentBuild.fullDisplayName}",
     "${env.BUILD_URL} has result ${currentBuild.result}",
     " ",
     "My sincerest apologies, your faithful servant,",
     "-- Jenkins"
     ]
     sendEmail(devopsTeam(),"Build Failed",message.join("\n"))
   }
 
  }
  // Brag about it.
  stage("Send Notification of Success"){
    def String[] message = [
    "Greetings,",
    "This is to inform you that the Docker image ${image_base_tag} version ${image_version_tag}",
    "This image contains Ubuntu:18.04 LTS  and",
    "the Puppet agent and Nagios NRPE server",
    "This was successfully built and pushed to the registry.",
    " ",
    "Sincerely,",
    "Your faithful servant."," Jenkins"
    ]
    sendEmail(qaTeam(),"tenna-ubuntu built",message.join("\n"))
  }
}