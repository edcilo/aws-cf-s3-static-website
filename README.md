# AWS S3 Bucket Deployment with CloudFormation and Makefile

This project provides an automated setup for creating an S3 bucket with static website hosting enabled, using an AWS CloudFormation template (`template.yml`) and a `Makefile` for automation. You can use the Makefile to deploy, upload files to the bucket, empty the bucket, and delete the CloudFormation stack.

## Requirements

- **AWS CLI** installed and configured on your local machine.
- **AWS IAM permissions** to create S3 buckets, manage bucket policies, and work with CloudFormation stacks.
- **Make** utility to use the Makefile commands.
- An AWS profile configured with `aws configure` (optional but recommended).

## Files

- **template.yml**: CloudFormation template that creates an S3 bucket with static website hosting enabled.
- **Makefile**: Automation script for deploying the CloudFormation stack, uploading files to S3, emptying the bucket, and deleting the stack.

## Parameters

The `template.yml` file requires the following parameter:

- `BucketName`: The name of the S3 bucket to create. It must be unique across all AWS accounts and adhere to S3 bucket naming rules.

## Makefile Commands

### 1. Deploy the CloudFormation Stack

This command creates the S3 bucket specified in `template.yml` and enables static website hosting.

```bash
make deploy AWS_PROFILE=<your-aws-profile> BUCKET_NAME=<your-bucket-name>
```

- AWS_PROFILE: (Optional) The name of the AWS CLI profile to use. If not specified, the default profile is used.
- BUCKET_NAME: The name of the S3 bucket to create, which will be passed to the CloudFormation template.

### 2. Upload Files to the S3 Bucket

After deploying the stack, you can upload files from a local directory to the S3 bucket:

```bash
make upload-files AWS_PROFILE=<your-aws-profile> BUCKET_NAME=<your-bucket-name> LOCAL_FILES_PATH=./path/to/your/files
```

- LOCAL_FILES_PATH: Path to the local directory containing the files to upload to the S3 bucket.

### 3. Empty the S3 Bucket

To delete all files in the S3 bucket without deleting the bucket itself, use:

```bash
make empty-bucket AWS_PROFILE=<your-aws-profile> BUCKET_NAME=<your-bucket-name>
```

This command removes all files from the bucket specified in BUCKET_NAME.

### 4. Delete the CloudFormation Stack

To delete the CloudFormation stack and remove the S3 bucket:

```bash
make clean AWS_PROFILE=<your-aws-profile>  BUCKET_NAME=<your-bucket-name>
```

This command first empties the S3 bucket and then deletes the CloudFormation stack.

## Notes

- Bucket Naming: Ensure that BucketName is globally unique and complies with S3 naming conventions.
- AWS Profile: If no AWS_PROFILE is provided, the commands will use the default AWS profile.
- Access Permissions: Make sure your AWS user has the necessary permissions for managing S3 buckets and CloudFormation stacks.

## License

This project is licensed under the MIT License.
