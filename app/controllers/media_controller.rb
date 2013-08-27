class MediaController < ApplicationController
 def show
  @id = params[:id]
  @media = Media.find(@id)

 end
end
