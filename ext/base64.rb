Base64.class_eval do

  module_function

  def urlsafe_encode64(bin,no_padding=nil)
    r = strict_encode64(bin).tr("+/", "-_")
    2.times{r.chomp!('=')} if no_padding
    r
  end

  def urlsafe_decode64(str,no_padding=nil)
    t = if no_padding
      case (str.size % 4)
        when 2; "#{str}=="
        when 3; "#{str}="
      else str end
    else str end
    strict_decode64(t.tr("-_", "+/"))
  end

end