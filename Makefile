STACK_NAME        := edc-static-website
BUCKET_NAME       := edc-static-website-bucket
AWS_PROFILE       := default
TEMPLATE_FILE     := template.yml
LOCALE_FILES_PATH := ./staticWebsite

create-stack:
	@echo "Creating cloudformation stack"
	aws cloudformation create-stack \
		--stack-name $(STACK_NAME) \
		--template-body file://$(TEMPLATE_FILE) \
		--parameters ParameterKey=BucketName,ParameterValue=$(BUCKET_NAME) \
		--profile $(AWS_PROFILE)

delete-stack:
	@echo "Deleting cloudformation stack"
	aws cloudformation delete-stack \
		--stack-name $(STACK_NAME) \
		--profile $(AWS_PROFILE)
	@echo "Cloudformation stack deletion initiated"
	aws cloudformation wait stack-delete-complete \
		--stack-name $(STACK_NAME) \
		--profile $(AWS_PROFILE)
	@echo "Cloudformation stack deleted"

wait-stack:
	@echo "Waiting for cloudformation stack to be created"
	aws cloudformation wait stack-create-complete \
		--stack-name $(STACK_NAME) \
		--profile $(AWS_PROFILE)
	@echo "Cloudformation stack created"

upload-files:
	@echo "Uploading files to S3 bucket"
	aws s3 cp $(LOCALE_FILES_PATH) s3://$(BUCKET_NAME) \
		--recursive \
		--profile $(AWS_PROFILE)
	@echo "Files uploaded to S3 bucket"

empty-bucket:
	@echo "Emptying S3 bucket"
	aws s3 rm s3://$(BUCKET_NAME) --recursive --profile $(AWS_PROFILE)
	@echo "S3 bucket emptied"

deploy: create-stack wait-stack upload-files
	@echo "Deployment completed"

clean: empty-bucket delete-stack
	@echo "Cleaned up"
