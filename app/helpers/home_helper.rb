module HomeHelper
  def setup_date
    date_range = (Date.parse('2018/01')..Date.parse('2023/12'))
    ary = date_range.map { |date| date.strftime("%Y年%-m月") }
    ary.uniq
  end
end
