namespace :code_challenge do
  desc "Refresh code challenge benchmark times"
  task :refresh => :environment do
    CodeChallenge.all.each do |code_challenge|
      code_challenge.test_left_code_sample_speed
      code_challenge.test_right_code_sample_speed
      code_challenge.save!
    end
  end
end
