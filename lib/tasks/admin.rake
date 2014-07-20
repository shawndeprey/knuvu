namespace :admin do
  namespace :user do
    task :verify, [:email] => :environment do |t, args|
      return puts "Email is required to verify user account." unless args[:email]
      @user = User.find_by_email(args[:email])
      return puts "Could not find user with email: #{args[:email]}" unless @user
      @user.verified = true
      @user.save
      puts "#{@user.email} - verified: #{@user.verified}"
    end
  end
end