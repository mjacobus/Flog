class String
  def to_slug
    downcase
      .gsub(/\s{1,}/,'-')
      .gsub(/[^\d\w-]/,'')
  end
end