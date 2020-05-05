Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # updates the progress on the currently downloaded yt video of id :id
  get '/tools/update_progress/:id/:progress', to: 'tools#update_progress'
  get '/tools/get_progress/:id', to: 'tools#get_progress'
  get '/tools/get_video/:id', to: 'tools#get_video'
  get '/tools/download_youtube/:url', to: "tools#download"

end
