namespace :one_time do
  desc "Fill in first- and last-name columns from name column."
  task :backfill_names, [:dry_run] => :environment do |t, args|
    args.with_defaults(dry_run: "true")
    User.find_each do |user|
      name = user.full_name
      first_name, last_name = name.match(/(\S+)(?:\s+(.+))?/).captures
      last_name ||= first_name
      if args[:dry_run] == "true"
        puts name
        puts "#{first_name} #{last_name}"
        puts "first_name: #{first_name}"
        puts "last_name: #{last_name}"
        puts
      else
        user.update first_name: first_name, last_name: last_name
      end
    end
  end
end
