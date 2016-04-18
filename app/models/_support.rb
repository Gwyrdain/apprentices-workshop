def format_hash(h)
  $formatted_hash = ''
  
    h.each do |item|
      $formatted_hash = $formatted_hash + "<b>#{item[0]}:</b> "
      if item[1].class.name == "Hash"
        $formatted_hash = $formatted_hash + "<table border=\"1\"><tr><td>#{format_hash(item[1])}</td></tr></table>"
      else
        $formatted_hash = $formatted_hash + "#{item[1]}<br>"
      end
    end
  
  return $formatted_hash
end

