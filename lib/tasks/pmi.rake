namespace :pmi do
  desc 'read user credentials from PMI registry'
  task get_credentials: :environment do
    puts 'updating...'
    Services::PageGetter.new.call
    puts 'done.'
  end
end