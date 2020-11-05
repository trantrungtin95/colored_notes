class NotesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_note, only: [:show, :edit, :update, :destroy]

    def index
        @notes = Note.where(user_id: params[:user_id], archive: "off").order('created_at desc')
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
        @note.save
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

    private

    def set_note
        @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:title, :user_id)
    end
     
end
