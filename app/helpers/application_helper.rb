module ApplicationHelper
    # Check command is declared
    def check_declare_format(input_string)
      parts = input_string.split(' ', 2)
      command = parts[0]
      argument = parts.length > 1 ? parts[1] : ''
      [command, argument]
    end

end
