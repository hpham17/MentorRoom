class Tag
  Skills = ["Software Engineering", "Finance", "BioTechnology", "Investment Banking", "Politics", "Accounting"].freeze

  Helps = ["Resume building", "Career Planning"].freeze

  def self.is_skill?(skill)
     Skills.include? skill
  end

  def self.is_help?(help)
     Helps.include? help
  end
end
