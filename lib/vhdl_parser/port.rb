module VHDL_Parser
  class Port
    attr_accessor :name, :direction, :comment, :type, :size, :left, :right, :size_dir

    def initialize
      @left = 0
      @right = 0
      @size_dir = "downto"
    end

    def to_s
      name.ljust(15) + "\t" +
      direction + "\t" + 
      type + "\t" + size + "\t" + comment + "\n"
    end

    def size
      if type =~ /std_logic_vector|unsigned|signed/
        "[#{@left} #{@size_dir} #{@right}]"
      else
        ""
      end
    end
  end
end
