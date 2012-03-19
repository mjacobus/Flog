class Post < ActiveRecord::Base
  has_attached_file :file,
    :styles => {
      :original => "1072x712>",
      :medium => "536x356>",
      :small => "268x178>",
      :thumb => "134x89>",
    }

  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/png']
  # not working
  validates_attachment_size :file, :less_than => 5.megabytes
  
  
  validates :title, :presence => true
  validates :slug, :presence => true, :uniqueness => {:case_sensitive => false}
  
  # set title and slug
  def title=(value)
    self[:title] = value
    self[:slug] = value ? value.to_slug : nil 
  end
  
  # accepts params year, month, day
  # will accept params: tag
  # list published posts
  def self.published(params = {})
    query = where('publish = ?', true)   
      .where('publication_date <= ?', Time.now)
      .order('publication_date DESC')
      
    year  = params[:year].to_i  if params[:year]
    month = params[:month].to_i if params[:month]
    day   = params[:day].to_i   if params[:day]
    
    ################
    # query by date
    ################ 
    if day 
      date = Date.new(year, month, day)    
    elsif month # query the intire month
      init_date = Date.new year, month, 1
      end_date = (init_date + 1.month) - 1.day
    elsif year # query for an intire year
      # first day of the given year
      init_date = Date.new year, 1, 1
      # last day of the given year 
      end_date = (Date.new year + 1) - 1.day
    end
   
    if date
      query = query.where('publication_date = ?', date )
    elsif init_date && end_date
      query = query.where('publication_date >= ? AND publication_date <= ?', init_date, end_date )
    end
    
    query
  end

end
