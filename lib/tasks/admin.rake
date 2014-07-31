namespace :admin do
  namespace :user do
    task :adminify, [:email] => :environment do |t, args|
      @user = User.find_by_email(args[:email])
      @user.admin = true
      @user.save
      puts "#{@user.email} - adminified: #{@user.admin?}"
    end
  end
end