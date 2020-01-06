class NotesController < ApplicationController

  before_filter :check_user_login
  @@DEFAULT_LIST_PAGE_SIZE = 5
  def create
    unless has_required_write_params?
      return render status: 422, json: {"error"=>"Parameters missing"}
    end
    note = Note.new(title: note_params[:title], content: note_params[:content], user_id: current_user_id)

    return render json: note if note.save

    render status: 422, json: note.errors.to_hash
  end

  #todo validate limit params
  def list
    #page_size = params[:page_size].blank? ? @@DEFAULT_LIST_PAGE_SIZE : params[:page_size].to_i
    #page_num = params[:page_num].blank? ? 0 : params[:page_num].to_i - 1
    #search_term = params[:search_term]
    note_list = nil
    if(params[:label].blank?)
      note_list = Note.where(user_id: current_user_id).includes(:labels)
    else
      note_list = Note.where(user_id: current_user_id, "labels.id": params[:label])
                      .includes(:labels)
    end

    #.limit(page_size).offset(page_num * page_size)
    render json: note_list
  end

  def update
    unless has_required_write_params?
      return render status: 422, json: {"error"=>"Parameters missing"}
    end

    begin
      note = Note.where(id:params[:id], user_id: current_user_id).first
    rescue ActiveRecord::RecordNotFound
      return render status: 422, json:{"error"=>"Invalid note id"}
    end

    labels = Label.where(id:note_params[:labels])
    note.title = note_params[:title]
    note.content = note_params[:content]
    note.labels = labels

    return render json: @@EMPTY_JSON_RESPONSE if note.save

    render status: 422, json: note.errors.to_hash
  end

  def delete
    begin
      Note.where(id:params[:id], user_id: current_user_id).first!.destroy
      render status: :ok, json: @@EMPTY_JSON_RESPONSE
    rescue ActiveRecord::RecordNotFound
      return render status: 422, json:{"error"=>"Invalid note id"}
    end
  end

  def add_label
    begin
      note = Note.where(id:params[:id], user_id: current_user_id).first!
      label = Label.where(id:params[:label_id]).first!
      note.labels << label
      note.save
      return head  :ok
    rescue ActiveRecord::RecordNotFound
      return render status: 422, json:{"error"=>"Invalid id"}
    end
  end

  #todo ::: check the actual query
  def remove_label
    note = Note.where(id:params[:id], user_id: current_user_id)
               .first!
    note.labels = note.labels.reject { |label| label.id == params[:label_id].to_i } #reject! not working
    head :ok
  end

  private
  def has_required_write_params?
    note_params.key?(:title) && note_params.key?(:content)
  end

  def note_params
    params[:note]
  end

end

