# encoding: utf-8
class String
  def to_slug
    downcase
      .gsub(/[áàâãäÂÃÀÁÄ]/,"a")
      .gsub(/[êẽèéëÊẼÈÉË]/,"e")
      .gsub(/[îĩìíïÎĨÌÍÏ]/,"i")
      .gsub(/[ôõòóöÔÕÒÓÖ]/,"o")
      .gsub(/[ûũùúüÛŨÙÚÜ]/,"u")
      .gsub(/[çÇ]/,"c")
      .gsub(/[^\s\w\n\-_]/,"")
      .strip
      .gsub(/\s{1,}/,'-')
  end
end