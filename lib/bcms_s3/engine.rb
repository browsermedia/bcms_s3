require 'browsercms'
require 'bcms_s3/s3_module'
require 'cms/attachments/s3_strategy'

module BcmsS3
  class Engine < ::Rails::Engine
    isolate_namespace BcmsS3
		include Cms::Module
		
    config.before_configuration do
      # Force ERB processing of YML file and look up credentials using 
      # rails environment name as hash key
      config.cms.attachments.s3_credentials = YAML.load(ERB.new(File.read("#{Rails.root}/config/bcms_s3.yml")).result)[Rails.env]
      config.cms.attachments.storage = :s3 
    end
    
		config.to_prepare do
      Cms::ContentController.send(:include, Cms::S3::ContentController)
      Cms::ApplicationController.send(:include, Cms::S3::ApplicationController)

      # ensure heroku caching disabled by default
      Cms::S3.heroku_caching = false if Cms::S3.heroku_caching.nil?
      
      # function to set domain prefix without url to 'www' is disabled by default
      Cms::S3.www_domain_prefix = false if Cms::S3.www_domain_prefix.nil?

	  end
  end
end
