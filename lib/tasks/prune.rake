namespace :prune do
  desc "Prunes old urls"
  task prune_old_urls: :environment do
    puts "Pruning old things"
    ShortenedUrl.prune
  end
end
