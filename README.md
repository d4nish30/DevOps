# DevOps
Automating Docker image upload to AWS ECR using Github Action.
1.Github repository setup.
	a.created a repository on github name devops.
	b.clone repository to local machine from CLI using command git clone <repository url>
	c.how to get repository url:-
		#open your github repository there is a green colour block name code click on code
		#there is a link copy that url that is repository url
	d.In cloned repository create your application "Hello world" name app.html.
2. Docker image creation.
	a.In same repository create a Dockerfile in which copy your application file app.html
	b.Try to choose small image which take less time to build and consume less storage.
	C.I choose node:16-alpine
	d.Try to write dockerfile in multistage, multistage image is very light.
	e.you can write dockerfile from command line using 'vim' or you can simply add a text docker file to repository
	f.docker file is a simple text file in which we give instruction how image will build or dockerfile is a blueprint of dockerimage.
	afer 1 and 2 step.
		add commit (git commit -m 'commit message')and push(git push origin branch name) to github.
3.AWS ECR Setup.
	a.visit to aws console login to your account.
	b.In services section go to ECR (elastic container registry) private registry.
	c.In private ECR there is a registries section, In which you got a option on right side create repository.
	d.click on create repository, create a private repository name 'devops' and click on create repository.
	e.In service section go to IAM (identity access managment) and click on users.
	f.In users on right side there is button create user, click on create user.
	g.create user and give a name and select 'I want to create an IAM user'.
	i.select 'attach policy directly' and select permission :-
		AmazonEC2ContainerRegistryFullAccess.
		AmazonElasticContainerRegistryPublicFullAccess
	j.click on create user then you get Console sign-in details keep this save with you, now your user is created.
	k.go to user list and click on your user i.e devops then you see option on right side create access key click on it.
	l.In use case select CLI and proceed then you get access key and secret access key download/copy these keys.
	M.go to CMD and navigate to your repository using cd command and type aws configure.(download aws cli from browser)
	N.then here access key and secret access key is required eneter these keys and region (find region from aws console)
4.Github action workflow.
	a.go to your repository on github and go to action option from upper side.
	b. click on setup a workflow yourself and write a workflow in yml syntax.
	c.To setup notification on push/pull you have two aoption:-
		#go to setting in github and select email notifications and enter your email id to get notification on email.
		#enable notification from workflow using APi i used Slack api.
		#to create slack api log on to slack click on create app button select from scratch give a name and hit enter then select incoming wehbooks and enanle Activate Incoming Webhooks.
		 then click on add new wehbook to workspace then select a channel on which you get notification of your workflow then you get wehbook url copy this url and save it
	d.go back to your github repository and click on setting, on left side column you get ecrets and variable click on it.
	  select action and click button new repository secret under repository secret in name give name to secret and in secret provide url (copy from slack).
	e.here i create 3 secret :-
				AWS_ACCESS_KEY_ID,AWS_SECRET_ACCESS_KEY these secrets is for login to aws 
				SLACK_WEBHOOK_URL for slack api
	f.also use appropriate caching to optimize the workflow
5.security and best practices.
	a.never hardcoding credentials always use secrets.
	b.give only necessary permission on AWS IAM
	c.create github repo and ECR repo private.
	d.enable scan on push while creating ECR repository for implement imagescanning for vulnerabilities 
	e.use yml validator for minimum error on workflow
	f.use "amazon ECR login action for github action" syntax for aws login in workflow
