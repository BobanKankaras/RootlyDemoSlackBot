module ApplicationHelper
    # Check command is declared
    def check_declare_format(str)
        if str.start_with?('declare') && str.length > 'declare'.length
          return str['declare '.length..-1]
        else
          return str
        end
    end

end
