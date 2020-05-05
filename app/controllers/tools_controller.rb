class ToolsController < ApplicationController
    require "securerandom"

    # calls the yt downloader with appropriate args
    def download
        @id = SecureRandom.random_number(1_000_000_000_000)
        progress = 0
        Video.create( id: @id, url: params[:url], progress: progress)

        Thread.start { call_python }
        render json: { id: @id }
    end

    def call_python
        system "python3 python/youtube_downloader.py #{@id} https://www.youtube.com/watch?v=#{params[:url]}"
    end

    # get progress from front end polling
    def get_progress
        @video = Video.find_by id: params[:id]
        render json: @video.progress 
    end

    # sends the video based on the id param
    def get_video
        send_file "public/tekblg-#{params[:id]}.mp4"
    end

    # get progress from python web hook
    def update_progress
        @video = Video.find( params[:id] ) 
        puts @video
        if @video.update( progress: params[:progress] )
            render json: :OK
        else
            render json: @recipe.errors, status: :unprocessable_entity
        end
    end
end
