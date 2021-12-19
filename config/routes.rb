Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/scores" => "scores#index"

  # get "/scores/:id" => "scores#show"

  post "/scores" => "scores#create"

  delete "/scores/:id" => "scores#destroy"

  get "/teams" => "teams#index"

  get "/teams/:id" => "teams#show"

  get "/datedteams/:id" => "teams#datedshow"

  get "/datedoppteams/:id" => "teams#datedoppshow"

  get "/oppteams/:id" => "teams#oppshow"

  get "/showteams/:id" => "teams#showteam"

  get "/records/:id" => "teams#records"

  get "/homerecords/:id" => "teams#homerecords"

  get "/awayrecords/:id" => "teams#awayrecords"
end
