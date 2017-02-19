class Tag
  SKILLS = ["Academia/Research", "Accounting", "Architecture", "Art", "Biotechnology", "Business Development", "Data Analytics", "Design", "Education", "Environmental Science", "Finance", "Government", "Hospitality", "Human Resources", "Investment Banking",
  "Law", "Marketing", "Mechanical Engineering", "Non-Profit", "Performing Arts", "Photography", "Public Relations", "Product Management", "Social Media", "Software Engineering", "Politics"]

  HELPS = ["Academia vs Industry", "Applying for grad school", "Career / Industry Trends", "Choosing a major", "Getting an internship", "Mock Interviews", "Networking", "Resume building", "Career Planning", "Navigating the PhD"]

  def self.is_skill?(skill)
     SKILLS.include? skill
  end

  def self.is_help?(help)
     HELPS.include? help
  end
end
