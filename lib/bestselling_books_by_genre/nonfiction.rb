require 'pry'

class BestsellingBooksByGenre::Nonfiction
  attr_accessor :title, :author, :summary, :link_to_buy

  @@all = []

  def self.all
    @@all
  end

  def self.scrape_nonfiction
    doc = Nokogiri::HTML(open("https://www.nytimes.com/books/best-sellers/"))
    doc.css("section.subcategory")[2].search("article.book")
  end

  def self.nonfiction_bestsellers
    scrape_nonfiction.each do |article|
      book = self.new
      @@all << book
      book.title = article.search("h3.title").text.strip
      book.author = article.search("p.author").text.gsub("by ", "").strip
      book.summary = article.search("p.description").text.strip
    end
  end


  #Fix this code later:
  #def link_to_buy
  #  @link_to_buy = self.class.scrape_nonfiction.search("footer.book-footer a").first.attr("href").value
  #end
end