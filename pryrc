require 'colored'

begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
rescue LoadError => err
  puts "no awesome_print :("
end

Pry.config.prompt = proc do |obj, nest_level, _|
    " #{nest_level} ".white_on_red +
    "⮀ ".red_on_yellow +
    "#{obj} ".black_on_yellow +
    "⮀ ".yellow
end
