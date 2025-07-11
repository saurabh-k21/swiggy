# Swiggy Clone

This project is a front-end clone of the Swiggy web application, built with React.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Available Scripts](#available-scripts)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)
- [DevOps](#devops)

## Features

- View a list of restaurants.
- See offers and deals.
- A visually appealing and responsive user interface.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Node.js and npm (or yarn) installed on your machine.

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/your_username/your_project_name.git
   ```
2. Install NPM packages
   ```sh
   npm install
   ```

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.<br />
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.<br />
You will also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.<br />
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.<br />
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.<br />
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can’t go back!**

If you aren’t satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you’re on your own.

You don’t have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn’t feel obligated to use this feature. However we understand that this tool wouldn’t be useful if you couldn’t customize it when you are ready for it.

## Project Structure

```
/
├── public/
│   └── index.html
├── src/
│   ├── App.css
│   ├── App.js
│   ├── bootstrap.min.css
│   ├── index.css
│   ├── index.js
│   ├── Components/
│   │   ├── BestRes.css
│   │   ├── BestRest.jsx
│   │   ├── Footer.jsx
│   │   ├── Navigate.css
│   │   ├── Navigate.jsx
│   │   ├── OfferBanner.css
│   │   ├── OffersBanner.jsx
│   │   ├── RestaurentChain.css
│   │   ├── RestaurentChain.jsx
│   │   ├── RestaurentOnline.css
│   │   └── RestaurentOnline.jsx
│   └── Photos/
│       ├── Banner1.png
│       ├── Banner2.png
│       ├── Banner3.png
│       ├── Banner4.png
│       └── Logo.png
├── package.json
├── Dockerfile
├── buildspec.yaml
└── appspec.yaml
```

## Dependencies

- @testing-library/jest-dom: ^5.17.0
- @testing-library/react: ^13.4.0
- @testing-library/user-event: ^13.5.0
- bootstrap: ^5.3.2
- react: ^18.2.0
- react-bootstrap: ^2.9.0
- react-dom: ^18.2.0
- react-scripts: 5.0.1
- web-vitals: ^2.1.4

## DevOps

This project is configured for deployment with AWS CodeDeploy.

- `appspec.yaml`: Configuration file for AWS CodeDeploy.
- `buildspec.yaml`: Build specification file for AWS CodeBuild.
- `Dockerfile`: For containerizing the application.





# User Data for Dependencies installations for AMAZON Linux 2:-

``` bash
#!/bin/bash
sudo yum -y update
sudo yum -y install ruby
sudo yum -y install wget
cd /home/ec2-user
wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto
sudo yum install -y python-pip
sudo pip install awscli
```

``` json

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::swiggy-demo-codepipeline-0001/*"
        }
    ]
}

```


For CodeDeploy to work, your EC2 instance needs the CodeDeploy Agent installed and running. You also need to attach an IAM Role to
  your EC2 instance that gives it permission to communicate with CodeDeploy and S3.


   1. Create an IAM Role for EC2:
       * Go to the IAM service in the AWS Console.
       * Create a new role.
       * Select AWS service and choose EC2 as the use case.
       * Attach the following AWS managed policies:
           * AmazonS3ReadOnlyAccess (so it can download artifacts from S3)
           * AmazonEC2RoleforAWSCodeDeploy
       * Give the role a name (e.g., EC2CodeDeployRole) and create it.


   2. Launch Your EC2 Instance:
       * When you launch your Amazon Linux 2 instance, in the "Advanced details" section, attach the IAM role you just created.
       * Important: In the "User data" field, paste the following script. This will automatically install the CodeDeploy agent and httpd
         when the instance first boots.

``` bash

   1     #!/bin/bash
   2     yum update -y
   3     yum install -y ruby wget httpd
   4     cd /home/ec2-user
   5     wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
   6     chmod +x ./install
   7     ./install auto
   8     systemctl start codedeploy-agent
   9     systemctl enable codedeploy-agent

```

   3. Configure Security Group: Ensure your EC2 instance's security group allows incoming traffic on port 80 (HTTP).

  Step 3: Create Your CodeDeploy Application


   1. Go to the CodeDeploy service in the AWS Console.
   2. Click Create application.
   3. Give it a name (e.g., swiggy-clone-app) and select EC2/On-Premises as the compute platform.
   4. Click Create application.
   5. Now, click Create deployment group.
   6. Give the group a name (e.g., swiggy-clone-dg).
   7. Service Role: Create a new service role that gives CodeDeploy permissions to interact with EC2. AWS will guide you through this.
   8. Deployment Type: Select In-place.
   9. Environment Configuration: Select Amazon EC2 instances and tag the EC2 instance you launched (e.g., by Name tag).
   10. Deployment Settings: Choose CodeDeployDefault.OneAtATime.
   11. Load Balancer: Uncheck "Enable load balancing".
   12. Click Create deployment group.


  Step 4: Create Your CodePipeline

  This is the final step where you tie everything together.


   1. Go to the CodePipeline service.
   2. Click Create pipeline.
   3. Pipeline Name: Give it a name (e.g., swiggy-clone-pipeline).
   4. Source Stage:
       * Select your source provider (e.g., GitHub, CodeCommit).
       * Connect to your repository and select the branch.
   5. Build Stage:
       * Select AWS CodeBuild as the provider.
       * Select the CodeBuild project you have been using.
   6. Deploy Stage:
       * Select AWS CodeDeploy as the provider.
       * Select the application and deployment group you just created.
   7. Review and Create pipeline.

``` bash
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Action": [
				"codebuild:BatchGetBuilds",
				"codebuild:StartBuild",
				"codebuild:StopBuild",
				"codebuild:BatchGetProjects",
				"codebuild:ListBuildsForProject"
			],
			"Resource": "arn:aws:codebuild:us-east-1:350903502296:project/swiggy"
		}
	]
}
```


