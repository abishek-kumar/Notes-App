class NotesController < ApplicationController

  before_filter :check_user_login
  @@DEFAULT_LIST_PAGE_SIZE = 5
  def create
    unless has_required_write_params?
      return render status: 422, json: {"error"=>"Parameters missing"}
    end
    note = Note.new(title: params[:title], content: params[:content], user_id: current_user_id)

    return head :created if note.save

    render status: 422, json: note.errors.to_hash
  end

  #todo validate limit params
  def list
    page_size = params[:page_size].blank? ? @@DEFAULT_LIST_PAGE_SIZE : params[:page_size].to_i
    page_num = params[:page_num].to_i - 1
    note_list = Note.where(user_id: current_user_id)
                    .includes(:labels)
                    .limit(page_size).offset(page_num * page_size)
    render json: format_list_response(note_list)
  end

  def save
    unless has_required_write_params?
      return render status: 422, json: {"error"=>"Parameters missing"}
    end

    begin
      note = Note.where([id:params[:id], user_id: current_user_id]).first
    rescue ActiveRecord::RecordNotFound
      return render status: 422, json:{"error"=>"Invalid note id"}
    end

    note.title = params[:title]
    note.content = params[:content]

    return head :ok if note.save

    render status: 422, json: note.errors.to_hash
  end

  def delete
    begin
      Note.where(id:params[:id], user_id: current_user_id).first!.destroy
      head :ok
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
    params.key?(:title) && params.key?(:content)
  end

  def format_list_response(note_list)
    note_list.map do |note|
      hash = {}
      hash.store(:note_id, note.id)
      hash.store(:title, note.title)
      hash.store(:content, note.content)
      label_arr = note.labels.map { |label| {:id=>label.id, :name=>label.name } }
      hash.store(:labels,label_arr)
      hash
      end
  end

end

