# Overview

A [BrowserCMS](http://www.browsercms.org) module to allow storage of images and files on the Amazon S3 storage facility

Note: This is fork of the original [bcms_s3 project](https://github.com/aunderwo/bcms_s3). It has been updated to work with BrowserCMS 3.5.0 and will be published as a gem named bcms_aws_s3 (mainly due to gem ownership).

## Features

* Allows uploaded files to be stored on Amazon S3. 
* Option to change caching to suit heroku and/or use 'www' as the prefix for the non-cms site.

Note that all file uploaded here are **publicly accessible** on AWS S3, though the paths are pretty hard to guess.

## Installation

	$ gem install bcms_aws_s3

And the following to your gem file
	
	gem "bcms_aws_s3"

Create a config/bcms_s3.yml with your credentials (see below). All files uploaded to the CMS will not be pushed and stored on Amazon s3.

## Using S3 for file storage

Adding this gem to your project will automatically configure the CMS to use AWS for storage. If you want to add the gem, but keep using the existing filesystem, configure the following in your config/application.rb.

    config.cms.attachments.storage = :filesystem	# This gems sets this value to :s3 when required.

Create a config/bcms_s3.yml file that contains your credentials and bucket. This should be in the following format:

    access_key_id: your AWS access key
    secret_access_key: your AWS secret access key
    bucket: your unique bucket name

### Configuring S3

Before you can upload files, you will need to create an S3 bucket (one or more) and configure that. You can configure in either:
	
	# config/bcms_s3.yml 
	bucket: your_project_bucket_name

Which will use the same bucket in development, testing and production. Or in an environment file (if you want buckets for each environment)

	# config/environments/production.rb
	config.cms.attachments.s3_bucket = "your_project_bucket_production"
	
	# config/environments/development.rb
	config.cms.attachments.s3_bucket = "your_project_bucket_development"

## Remaining todos

1. Final 3.5.0 release 
1. Ensure :style param works for S3 (since it does in core now)
1. cname's don't work currently
1. Attachments are public

## Using this module with [Heroku](http://heroku.com)

If using this module in conjunction with deployment on heroku you should probably turning heroku caching on by setting Cms::S3.heroku_caching in config/initializers/browsercms.rb to true.

In order to avoid putting your secret AWS key in the bcms_s3.yml file, you can take advantage of [heroku's config vars](http://docs.heroku.com/config-vars). Use ERB to read the values from the environment.  This way you can safely commit your bcms_s3.yml file to the repository without revealing your amazon credentials.

	development:
	  access_key_id:  hardcoded_key
	  secret_access_key:  hardcoded_key
	  bucket:  hardcoded_bucket_name

	staging:
	  access_key_id:  <%= ENV['s3_access_key_id'] %>
	  secret_access_key:  <%= ENV['s3_secret_access_key'] %>
	  bucket: <%= ENV['s3_bucket'] %>

	production:
	  access_key_id:  <%= ENV['s3_access_key_id'] %>
	  secret_access_key:  <%= ENV['s3_secret_access_key'] %>
	  bucket:  <%= ENV['s3_bucket'] %>

Set the config vars on heroku to get it working there as well.

    heroku config:add s3_access_key_id='your AWS access key'
    heroku config:add s3_secret_access_key='your AWS secret access key'
    heroku config:add s3_bucket='your unique bucket name'

## www prefix for non cms urls
If your non cms domain is www.myapp.com rather than app.com this can be enabled by setting Cms::S3.www_domain_prefix in config/initializers/browsercms.rb to true.

## using cnames to your S3 bucket
If you've set up CNAMES in your DNS to point to your bucket, then you can enable the use of that instead of the FQDN ending in amazonaws.com by setting Cms::S3.options[:s3_cname] in your bcms_s3.yml file.

## Important things to note
1. The bcms_s3.yml should be excluded from public repositories (e.g github) since it contains your secret AWS key which should **never** be revealed to the public.   
**Please note**. This no longer applies since the access keys and buckets are now specified in environmental variables and therefore the bcms_s3.yml file now contains just references to these environmental variables.
2. Changing from local storage to S3 storage will require you to re-upload all your files (or copy the tree to s3)

## Contributors

* Original work on S3 storage for BrowserCMS by [Neil Middleton](http://github.com/neilmiddleton/)
* v2.1 by [Anthony Underwood](https://github.com/aunderwo)
