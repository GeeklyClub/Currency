
class Downloader
  @queue = :block

  def self.perform
    url = 'http://www.imf.org/external/np/fin/data/rms_five.aspx?tsvflag=Y'
    `wget --no-check-certificate --read-timeout=10 --output-document '#{Rails.root.join("public/xxx.xls")}' '#{url}'`
  end
end
