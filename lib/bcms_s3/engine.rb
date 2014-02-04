require 'browsercms'
require 'bcms_s3/s3_module'
require 'cms/attachments/s3_strategy'

module BcmsS3
  class Engine < ::Rails::Engine
    isolate_namespace BcmsS3
		include Cms::Module

    config.before_configuration do
      puts '=============================================================='
      puts '=============================================================='

      config.cms.attachments.s3_credentials = "#{Rails.root}/config/s3.yml"
      config.cms.attachments.storage = :s3 
    end
    
    config.to_prepare do
      Cms::ApplicationController.send(:include, Cms::S3::ApplicationController)

      # ensure heroku caching disabled by default
      Cms::S3.heroku_caching = false if Cms::S3.heroku_caching.nil?
      
      # function to set domain prefix without url to 'www' is disabled by default
      Cms::S3.www_domain_prefix = false if Cms::S3.www_domain_prefix.nil?

    end


  end
end
