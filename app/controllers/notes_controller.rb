class NotesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_note, only: [:show, :edit, :update, :destroy]

    def index
        @notes = Note.where(user_id: params[:user_id], archive: "off").order('index asc')
    end

    def show
    end

    def new
        @note = Note.new(user_id: params[:user_id])
    end

    def edit
        @note = Note.find(params[:id])
    end

    def create
        @note = Note.new(note_params)
        if note_params[:title].strip.present?
            Note.all.each do |note|
                new_index = note.index + 1
                note.update(index: new_index)
            end 
            @note.update(index: 0)
        end
    end

    def update
        if note_params[:title].strip.present?
            @note.update(note_params)
        else
            @note.destroy
        end
    end

    def destroy
        @tags = @note.note_tags.map(&:tag)
        @tags.each do |tag|
            if tag.note_tags.count == 1
                tag.destroy
            end
        end
        @note.destroy
        redirect_to user_notes_path(@current_user)
    end

    def new_line_item
        @note = Note.find(params[:id])
        @line_item = LineItem.new
    end
    
    def add_line_item
        @note = Note.find(params[:id])
        # "  ".strip.present?
        if params[:content].strip.present?
        @line_item = LineItem.create(content: params[:content], note_id: params[:id])
        end
    end 
    
    def edit_line_item
        @note = Note.find(params[:id])
        @line_item = LineItem.find(params[:line_item_id])
    end

    def update_line_item
        @note = Note.find(params[:id])
        @line_item = LineItem.find(params[:line_item_id])
        if !params[:content].strip.present?
            @line_item.destroy
        else
            @line_item.update(content: params[:content])
        end
    end

    def destroy_line_item
        @line_item = LineItem.find(params[:line_item_id])
        @line_item.destroy
        redirect_to user_notes_path(@current_user)
    end

    def pin
        @note = Note.find(params[:id])
        @note.update(pin: "on")
        redirect_to user_notes_path(@current_user)
    end

    def unpin
        @note = Note.find(params[:id])
        @note.update(pin: "off")
        redirect_to user_notes_path(@current_user)
    end

    def archive
        @note = Note.find(params[:id])
        @note.update(archive: "on")
        redirect_to user_notes_path(@current_user)
    end

    def unarchive
        @note = Note.find(params[:id])
        @note.update(archive: "off")
        redirect_to archive_index_user_notes_path(@current_user)
    end

    def archive_index
        @notes = Note.where(user_id: params[:user_id], archive: "on").order('created_at desc')
    end

    def color
        @note = Note.find(params[:id])
        @note.update(color: params[:color])
    end 

    def reminder
        @note = Note.find(params[:id])
    end

    def set_reminder
        @note = Note.find(params[:id])
        if params[:reminder] != ""
          @note.update(reminder: Time.parse(params[:reminder]))
        end
    end


    def set_index
        # TODO: move to model. Follow convention: thin controller, fat model ==> write unit test
        # naming: follow underscore convention. indexstart --> index_start, noteend --> note_end
        if params[:newposition] > params[:position]
            notes_tart = Note.find(params[:note_id])
            index_start = notes_tart.index + 1
            if params[:nextnote_id].nil?
                notes = Note.all.order('index asc').where(index: [index_start...nil])
            else
                note_end = Note.find(params[:nextnote_id])
                index_end = note_end.index
                notes = Note.all.order('index asc').where(index: [index_start...index_end])
            end
            notes.each do |note|
                new_index = note.index - 1
                note.update(index: new_index)
            end
            n = notes.last.index + 1
            notes_tart.update(index: n)
        elsif params[:newposition] < params[:position]
            notes_tart = Note.find(params[:nextnote_id])
            index_start = notes_tart.index
            note_end = Note.find(params[:note_id])
            index_end = note_end.index
            notes = Note.all.order('index asc').where(index: [index_start...index_end])
            notes.each do |note|
                new_index = note.index + 1
                note.update(index: new_index)
            end
            n = notes.first.index - 1
            note_end.update(index: n)
        end
    end 

    def reminder_notes
        # Note.where(user_id: current_user.id).where(reminder_at: )
        start_time = Time.now 
        notes = Note.where(user_id: @current_user.id, reminder: start_time.beginning_of_minute..start_time.end_of_minute )
        render json: notes
    end

    def add_tag
        @note = Note.find(params[:id])
    end

    def create_tag
        @tag = Tag.where(user_id: params[:user_id]).find_by_tag_name(params[:tag_name])
        if @tag.nil?
            @tag = Tag.create(user_id: params[:user_id], tag_name: params[:tag_name])
        end
        if NoteTag.where(note_id: params[:id], tag_id: @tag.id).empty?
            @note_tag = NoteTag.create(note_id: params[:id], tag_id: @tag.id)
        end
        redirect_to user_notes_path(@current_user)
    end

    def destroy_tag
        @note_tag = NoteTag.find(params[:note_tag_id])
        @tag = @note_tag.tag
        if @tag.note_tags.count == 1
            @tag.destroy
        else
            @note_tag.destroy
        end
        
        redirect_to user_notes_path(@current_user)
    end
    

    def select_tag
        @tag = Tag.find(params[:tag_id])
        @notes = @tag.note_tags.map(&:note)
    end
    
    

    private

    def set_note
        @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:title, :user_id)
    end
     
end
