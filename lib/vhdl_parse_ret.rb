require "vhdl_parser"

filename = ARGV[0]
entity = VHDL_Parser.parse_file(filename)

#TODO: Handle generics
#TODO: parse command-line arguments in a real way (e.g., -h, -o asdf.as, etc.)
output_type = ARGV[1]
case output_type
when "signals"
    entity.ports.each_with_index do |port, index|
        print "signal s_" + port.name + " : " + port.type + port.size + ";"

        if index != entity.ports.length - 1
            print "\n"
        end
    end
when "component"
    puts "component " + entity.name + " is"
    puts "	port("
    entity.ports.each_with_index do |port, index|
        print "		" + port.name + " : " + port.direction + " " + port.type + port.size

        if index != entity.ports.length - 1
            print ",\n"
        end
    end
    print "\n	);\nend component;"
when "instantiation"
    #TODO: auto-increment this number
    puts "inst_" + entity.name + "_0 : " + entity.name
    puts "	port map("
    entity.ports.each_with_index do |port, index|
        print "		" + port.name + " => s_" + port.name

        if index != entity.ports.length - 1
            print ",\n"
        end
    end
    print "\n	);"
when "instantiation_short"
    #TODO: auto-increment this number
    puts "inst_" + entity.name + "_0 : entity work." + entity.name
    puts "	port map("
    entity.ports.each_with_index do |port, index|
        print "		" + port.name + " => s_" + port.name

        if index != entity.ports.length - 1
            print ",\n"
        end
    end
    print "\n	);"
else 
    puts "Not a valid output type"
end

