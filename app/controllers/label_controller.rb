class LabelController < ApplicationController
  before_filter :check_user_login

  def create
    return render status: 422, json: {"error"=>"Parameters missing"} if params[:name].blank?

    label = Label.new(name: params[:name], user_id: current_user_id)

    return head :created if label.save

    render status: 422, json: note.errors.to_hash
  end

  def edit
    return render status: 422, json: {"error"=>"Parameters missing"} if params[:title].blank?

    begin
      label = Label.where([id:params[:id], user_id: current_user_id]).first
    rescue ActiveRecord::RecordNotFound
      return render status: 422, json:{"error"=>"Invalid note id"}
    end
    label.name = params[:name]

    return head :ok if label.save

    render status: 422, json: note.errors.to_hash
  end

  def delete
    begin
      Label.where([id:params[:id], user_id: current_user_id]).first.destroy
      head :ok
    rescue ActiveRecord::RecordNotFound
      return head 400
    end
  end

end
