Puppet::Parser::Functions::newfunction(:concat_titles, :type => :rvalue, :doc => <<-'ENDOC'

  *Examples:*

  $foo = {
    'marc' => {
      loves => 'debo',
    },
    'debo' => {
      loves => 'marc',
    }

  $bar = concat_titles($foo, append, "@gmail.com")

  *Would return:*

  $bar = {
    'marc@gmail.com' => {
      loves => 'debo',
    },
    'debo@gmail.com' => {
      loves => 'marc',
    }
}

  ENDOC

) do |args|

  raise ArgumentError, ("concat_titles(): wrong number of arguments (#{args.length}; must be 3)") if args.length != 3
  hash = Hash.new()

  args[0].each do |title, params|
    case args[1]
    when "prepend"
      new_title = "#{args[2]}#{title}"
    when "append"
      new_title = "#{title}#{args[2]}"
    end
    hash["#{new_title}"] = params
  end

  return hash

end
