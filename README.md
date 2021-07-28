# AWS CloudFormation example with Classic ELB and Auto Scaling Group

This cloudformation template is simple example to create a highly available EC2 instance, load balanced using classic ELB, and with auto scaling configured.

## Deploy CloudFormation

Current Repository uses GitHub Actions to deploy the cloudformation template in the AWS. Triggers are disabled and it is manual at the moment.

Once you have made the necessary change in either CloudFormation template or the GitHub Action [workflow file](https://github.com/ashish246/aws-cloudformation-elb-asg/blob/main/.github/workflows/main.yml), then navigate to the main page of GitHub repository > Click `Actions` > In the left sidebar, click `Deploy CloudFormation Stacks` > Click `Run Workflow`.

You should see the pre-filled data > Validate/update the input parameters > `Run Workflow`.

## Deploy using AWS CLI

- Install [AWS CLIv2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) and the [configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) it respective to you local system. Create a named profile for your name e.g. `ashish` is the profile name in my case
- Clone this repo locally and make the necessary changes to cloudformation template
- Switch to the repository directory

### Deploy it through YAML file

Run below command to deploy the cloudformation template using YAML file directly:

```bash
aws cloudformation deploy --template-file aws-elb-asg.yaml --stack-name aws-elb-asg-stack --parameter-overrides EnvironmentName=test InstanceType=t2.small KeyName=my-catch-key --profile ashish
```

To delete the stack from local, run the below command:

```bash
aws cloudformation delete-stack --stack-name aws-elb-asg-stack --profile ashish
```

### Deploy it through S3 file

- Create a bucket in s3 either through command or console e.g. bucket name `test-asg`
- Upload the cloudformation template in that `test-asg` s3 bucket by running below command:

```bash
aws s3 cp aws-elb-asg.yaml s3://test-asg/ --profile ashish
```

- Run the below command to create the stack using the S3 file:

```bash
aws cloudformation create-stack --stack-name aws-elb-asg-stack --template-url https://test-asg.s3.ap-southeast-2.amazonaws.com/aws-elb-asg-stack --parameters ParameterKey=EnvironmentName,ParameterValue=test ParameterKey=InstanceType,ParameterValue=t2.small ParameterKey=KeyName,ParameterValue=my-catch-key --profile ashish
```

- To delete the stack from local, run the below command:

```bash
aws cloudformation delete-stack --stack-name aws-elb-asg-stack --profile ashish
```
