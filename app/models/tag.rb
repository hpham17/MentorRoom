class Tag
  Skills = ["Software Engineering", "Finance", "BioTechnology", "Investment Banking", "Politics", "Accounting"].freeze

  Helps = ["Academia vs. Industry", "Applying for grad / professional school", "Balancing family and career", "Career / Industry Trends", "Choosing a Major", "Mock Interviews", "Networking / Introductions to others in my field", "Resume / CV Review", "Career Planning", "Transitioning to life after College"].freeze

  def self.is_skill?(skill)
     Skills.include? skill
  end

  def self.is_help?(help)
     Helps.include? help
  end
end
