class SitesController < ApplicationController

  def show
    site = Site.find(params[:id])
    respond_with json: site
  rescue ActiveRecord::RecordNotFound
    respond_message message: "site not found", status: 404
  end

  def verify
    url = params[:url]
    site = Site.find_by_url
    if site

      render json: site.to_json, status: 200
    else
      respond_message message: "site not found with url #{url}", status: 404
    end
  end

  def create
    site = Site.new(params[:site])
    site.save!
  rescue ActiveRecord::RecordInvalid => e
    respond_message message: e.message, status: 400
  end

  def update
    site = Site.find(params[:id])
    update = site.update params[:site]
    if update
      respond_message "site update successful", status: 200
    else
      respond_message "site update failed for some unknown reason", status: 500
    end
  rescue ActiveRecord::RecordNotFound
    respond_message "site not found", status: 404
  rescue ActiveRecord::UnknownAttributeError
    respond_message "incorrect params", status: 400
  end

  def destroy
    deleted = Site.delete params[:id]
    if deleted > 0
      respond_message "site deleted successfully", status: 200
    else
      respond_message message: "site not found", status: 404
    end
  end
end
