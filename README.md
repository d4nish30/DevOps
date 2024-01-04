# Automating Docker image upload to AWS ECR using Github Action.

## 1.Github repository setup.
- Create a repository on github name DevOps.
- clone repository to local machine from CLI using command
```sh
git clone https://github.com/d4nish30/DevOps.git
```
- In cloned repository create your application "Hello world" name app.html.
## 2. Docker image creation.
- Docker file is a simple text file in which we give instruction how image will build or dockerfile is a blueprint of dockerimage.
- You can write dockerfile from command line using 'vim' or you can simply add a text file name Dockerfile to repository
```sh
vim Dockerfile
```
- In same repository create a Dockerfile in which your application file app.html
- Try to choose small image which take less time to build and consume less storage, I choose node:16-alpine.
- Try to write dockerfile in multistage, multistage image is very light.
- Now add commit and push to repository
```sh
# add all changes
git add .
# commit
git commit -m 'commit message'
# push
git push origin main
```
## 3.AWS ECR Setup.
- Visit to AWS console login to your account.
- In services section go to ECR (Elastic Container Registry) private registry.
- In private ECR there is a registries section, In which you got a option on right side create repository.
- Click on create repository, create a private repository name 'devops' and click on create repository.
- In service section go to IAM (Identity Access Managment) and click on users.
- In users on right side there is button create user, click on create user.
- Create user and give a name and select 'I want to create an IAM user'.
- Select 'attach policy directly' and select permission :-
  - AmazonEC2ContainerRegistryFullAccess.
  - AmazonElasticContainerRegistryPublicFullAccess
- Click on create user then you get Console sign-in details keep this save with you, now your user is created.
- Go to user list and click on your user i.e devops then you see option on right side create access key click on it.
- In use case select CLI and proceed then you get access key and secret access key download/copy these keys.
- Go to CMD and navigate to your repository using cd command and type aws configure.(download aws cli from browser)
- Then, access key and secret access key is required enter these keys and region (find region from aws console)
## 4.Github action workflow.
- Go to your repository on github and go to action option from upper side.
- Click on setup a workflow yourself and write a workflow in yml syntax.
- To setup notification on push/pull you have two aoption:-
  - Go to setting in github and select email notifications and enter your email id to get notification on email.
  - Enable notification from workflow using API, i used Slack API.
  - To create slack API, login to slack click on create app button select from scratch give a name and hit enter then select incoming wehbooks and enanle Activate Incoming Webhooks.
    then click on add new wehbook to workspace then select a channel on which you get notification of your workflow then you get wehbook url copy this url and save it
- Go back to your github repository and click on setting, on left side column you get secrets and variable click on it.
- Select action and click button new repository secret under repository secret in name give name to secret and in secret provide url (copy from slack).
- Here i create 3 secret :-
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY these secrets is for login to aws 
  - SLACK_WEBHOOK_URL for slack api
- Also use appropriate caching to optimize the workflow
## 5.security and best practices.
- Never hardcoding credentials always use secrets.
- Give only necessary permission on AWS IAM
- Create github repo and ECR repo private.
- Enable scan on push while creating ECR repository for implement imagescanning for vulnerabilities 
- Use yml validator for minimum error on workflow
- Use "amazon ECR login action for github action" syntax for aws login in workflow
