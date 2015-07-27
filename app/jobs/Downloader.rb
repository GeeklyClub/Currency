
class Downloader
  @queue = :block

  def self.perform
    url = 'http://www.imf.org/external/np/fin/data/rms_five.aspx?tsvflag=Y'
    `wget --content-disposition --output-document '#{Rails.root.join("public/rms.xls")}' '#{url}'`
  end
end
