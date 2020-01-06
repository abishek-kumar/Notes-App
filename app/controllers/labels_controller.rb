class LabelsController < ApplicationController
  before_filter :check_user_login

  def create
    return render status: 422, json: {"error"=>"Parameters missing"} if label_params[:name].blank?

    label = Label.new(name: label_params[:name], user_id: current_user_id)

    return render json: label if label.save

    render status: 422, json: note.errors.to_hash
  end

  def edit
    return render status: 422, json: {"error"=>"Parameters missing"} if label_params[:name].blank?

    begin
      label = Label.where(id:params[:id], user_id: current_user_id).first
    rescue ActiveRecord::RecordNotFound
      return render status: 422, json:{"error"=>"Invalid note id"}
    end
    label.name = label_params[:name]

    return render json: @@EMPTY_JSON_RESPONSE if label.save

    render status: 422, json: note.errors.to_hash
  end

  def delete
    begin
      Label.where(id:params[:id], user_id: current_user_id).first.destroy
      return render json: @@EMPTY_JSON_RESPONSE
    rescue ActiveRecord::RecordNotFound
      return head 400
    end
  end

  def list
    labels = Label.where(user_id: current_user_id);
    render json: labels
  end

  private
      def label_params
        params[:label]
      end

end
