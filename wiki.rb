#ROUTE PRIORITY IS REAL
#ROUTE PRIORITY IS REAL
#ROUTE PRIORITY IS REAL
#ROUTE PRIORITY IS REAL

require "sinatra"
require "uri" #****cant post spaces to the urlç need to fix that

set :bind, "0.0.0.0"

def page_content(title)
  File.read("pages/#{title}.txt")
 rescue Errno::ENOENT
  return nil
end

def save_content(title,content) #take wiki pages data n save it 
  File.open("pages/#{title}.txt", "w") do |f|
    f.print(content)
  end
end

def delete_content(title)
  File.delete("pages/#{title}.txt")
end

get "/" do #default "/" #erb ->will render views/welcome.erb
  erb :welcome #, layout: :page -> since we use the same template for all the pages we can just make it                                    default by naming page.erb file layout.erb
end

#get "/:title" do #Visit /PageName to view a page.
#  params[:title]
#end

#get "/test" do
#  erb :test
#end

get "/new" do 
  erb :new
end

get "/:title" do
  #1 page_content(params[:title])
  #2
  @title = params[:title]
  @content = page_content(@title)
  erb :show
end

get "/:title/edit" do #thank to /edit. we can write this here
  @title = params[:title]
  @content = page_content(@title)
  erb :edit
end

post "/create" do
  save_content(params["title"], params["content"])
  redirect URI.escape("/#{params["title"]}") #****uri
end

put "/:title" do
  save_content(params["title"], params["content"])
  redirect URI.escape("/#{params["title"]}")
end

delete "/:title" do
  delete_content(params[:title])
  redirect "/"
end




