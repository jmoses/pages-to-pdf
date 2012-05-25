require 'open-uri'

class Page
  TARGET = "QuickLook/Preview.pdf"

  attr_accessor :url

  def initialize( url = nil )
    @url = url
  end

  def pdf
    tempfile = fetch_file
    preview( tempfile.path ).tap do
      tempfile.close
    end
  end

  protected
    def fetch_file
      Tempfile.new("pdfzip", Rails.root.join("tmp") ).tap do |file|
        open(url, 'rb:utf-8') {|url| file << url.read }
        file.rewind
      end
    end

    def preview( path )
      Zip::ZipFile.open(path) do |zipfile|
        zipfile.read( TARGET )
      end
    end
end
