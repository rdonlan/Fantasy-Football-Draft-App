Rails.application.routes.draw do
  get 'drafttrack/home'
  get 'drafttrack/contact'
  get 'my_home_page/home'
  root "drafttrack#startDraft"

  get "/drafttrack" => "drafttrack#startDraft"

  get "/" => "drafttrack#startDraft"

  post "/" => "drafttrack#draftPlayer"

  post "drafttrack/destroy_all" 
end