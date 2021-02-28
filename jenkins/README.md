# SERVICE - JENKINS CI/CD

## Follow docs here: 

- https://hub.docker.com/r/bitnami/jenkins/
- https://www.jenkins.io/doc/book/getting-started/

## Some useful commands:

```
~/devops/deploy.sh services jenkins up         : Up JENKINS to production

~/devops/deploy.sh services jenkins upload     : Upload the current jenkins data to S3
~/devops/deploy.sh services jenkins download   : Download data from S3 to current jenkins_data folder

```

Service Info

```
Public Domain: http://jenkins.joco.asia:8080/

Jenkins Admin     : root

Jenkins Developer : developer
Password          : t7dM2rrEqjZ7

Gitlab User  : jenkinsuser
Token        : t897JiAr9tSB1sutedvZ


```

# JENKINS - HOW TO CONFIG

```
Plugins should be installed:

- GitLab
- Gitlab API
- SSH

How to create gitlab CI/CD user
    Gitlab -> Setting -> Access Tokens

How to update URL in Jenkins
    https://:t897JiAr9tSB1sutedvZ@gitlab.tintech.org/joco/backend.git

Adding Credentials (Ec2 keypair adding)
- Jenkins -> Credentials -> System -> Global credentials
- Choose:'SSH Username with private key'
- Enter Username: ubuntu
- Enter Private Key:

Adding Server SSH (Add EC2 server)
- Jenkins -> Manage Jenkins -> Configure System -> SSH remote hosts

Create new Jenkins Item
- New Item -> Freestyle Project
- Build -> Execute shell script on remote host using ssh

Manage Jenkins User with Role-based Authorization Strategy Plugin
Docs: https://www.thegeekstuff.com/2017/03/jenkins-users-groups-roles/
How to set role: https://www.youtube.com/watch?v=v-AVR0UoB-c

- Install Role-based Authorization Strategy Plugin
- Manage Jenkins -> Configure Global Security -> Role-Based Strategy
- Manage Jenkins -> Manage and Assign Roles

Manage Jenkins User with Jenkins build-in Project-based Matrix Authorization Strategy
- Manage Jenkins -> Configure Global Security -> Project-based Matrix Authorization Strategy
- Project -> Configure -> Enable project-based security -> Tick all

```
