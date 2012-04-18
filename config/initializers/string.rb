# encoding: utf-8
class String
  def to_slug
    downcase.strip
      .gsub(/\s{1,}/,'-')
      .gsub(/[áàâãäÂÃÀÁÄ]/,"a")
      .gsub(/[êẽèéëÊẼÈÉË]/,"e")
      .gsub(/[îĩìíïÎĨÌÍÏ]/,"i")
      .gsub(/[ôõòóöÔÕÒÓÖ]/,"o")
      .gsub(/[ûũùúüÛŨÙÚÜ]/,"u")
      .gsub(/[çÇ]/,"c")
  end
end