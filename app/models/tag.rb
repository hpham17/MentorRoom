class Tag
  SKILLS = ["Software Engineering", "Finance", "BioTechnology", "Investment Banking"].freeze

  def self.is_skill?(skill)
     SKILLS.include? skill
  end
end
