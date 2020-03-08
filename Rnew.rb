 def check_if_user_gave_input()
	abort("rails: missing input") if ARGV.empty?
end

def create_rails(name)
  system("rails new -d postgresql #{name}")
end

def perform
  check_if_user_gave_input()
  create_rails(ARGV.join("_"))
  Dir.chdir(ARGV.join("_"))
  File.write("Gemfile", "gem 'table_print'\ngem 'faker'\ngem 'devise'\ngem 'letter_opener'", mode: "a")
  system("bundle install")
  system("rails db:create")
  puts "<< Installation de Devise >>"
  system("rails generate devise:install")
  system("rails generate devise User")
  system("rails db:migrate")
  system("rails generate devise:views")
  system("rails g controller home index")
  Dir.chdir("config")
  File.write("routes.rb", "Rails.application.routes.draw do\n  root 'home#index'\n  devise_for :users\nend", mode: "w")
  puts "<== App Rails instaléé <> Devise installée ==>"
  puts " <== Go to http://localhost:3000/ ==>"
  puts "  <== Good luck, Have fun ==>"
end

perform
