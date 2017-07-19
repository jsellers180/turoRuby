class Hash
  
    def downcase
      dhash={}
      self.each_pair do |k,v|
          dhash[k.downcase] = v.downcase
      end
      dhash
    end

    def to_s
      string=""
      self.each_pair do |k,v|
        string << k.to_s+"="
        string << v.to_s+" "
      end
      string
    end
end

class Array
    def downcase
      self.collect! do |item|
        item.downcase
      end
      self
    end

    def to_s
      self.join(",")
    end
end

class String
  attr_accessor :color
  def array_me
    array = []
    self.strip.split(" ").each do |item|
        keys,value = item.split("=")
        keys.split(",").each do |key|
            array << "#{key}=#{value}"
        end
    end
    array
  end
  
  def color(n=31); "\e[#{n}m#{self}\e[0m"; end
  
end