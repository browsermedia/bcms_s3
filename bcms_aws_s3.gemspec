# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bcms_s3/version"

Gem::Specification.new do |s|
  s.name        = "bcms_aws_s3"
  s.version     = BcmsS3::VERSION

  s.files = Dir["{app,config,db,lib}/**/*"]
  s.authors = ["BrowserMedia", "Anthony Underwood", "Neil Middleton"]
  s.summary = %q{An S3 module for BrowserCMS}
  s.description = %q{A BrowserCMS module that stores attachments on Amazon S3 rather than on the filesystem.}
  s.email = %q{github@browsermedia.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files += Dir["app/**/*"]
  s.files += Dir["config/**/*"]
  s.files += Dir["db/**/*"]
  s.files += Dir["lib/**/*"]
  s.files += Dir["Gemfile", "LICENSE.txt", "COPYRIGHT.txt", "GPL.txt" ]

  s.test_files += Dir["test/**/*"]
  s.test_files -= Dir['test/dummy/**/*']

  s.homepage = %q{https://github.com/browsermedia/bcms_s3}
  s.require_paths = ["lib"]
  s.rubyforge_project = s.name

  s.add_dependency("aws-sdk", ">= 1.5.0")
  s.add_dependency("browsercms", "< 3.6.0", ">= 3.5.0.rc1")
end


