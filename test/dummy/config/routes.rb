Rails.application.routes.draw do

  mount BcmsS3::Engine => "/bcms_s3"

  mount_browsercms
end
