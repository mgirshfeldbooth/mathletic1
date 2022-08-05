namespace :slurp do
  desc "TODO"
  task exercisefile: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join("lib", "csvs", "exercisefile.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      e = Exercise.new
      e.question = row["Question"]
      e.answer = row["Answer"]
      e.difficulty = row["Difficulty"]
      e.save

      puts "#{e.answer} saved"
    end
    puts "There are now #{Exercise.count} rows in the Exercises table"
  end

end
