class Admin::AdminController < ApplicationController
  before_action :require_authenticate
  before_action :require_admin


end
