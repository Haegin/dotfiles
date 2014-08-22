# if defined?(Gem.post_reset_hooks)
#   Gem.post_reset_hooks.reject!{ |hook| hook.source_location.first =~ %r{/bundler/} }
#   Gem::Specification.reset
#   load 'rubygems/custom_require.rb'
#   alias gem require
# end

# require 'colored'
# require 'bond'
# require 'pry-coolline'

begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
rescue LoadError => err
  puts "no awesome_print :("
end

# Pry.config.prompt = proc do |obj, nest_level, _|
#     " #{nest_level} ".white_on_red +
#     "⮀ ".red_on_yellow +
#     "#{obj} ".black_on_yellow +
#     "⮀ ".yellow
# end

begin
  require 'hirb'
rescue LoadError
  # Missing goodies, bummer
end

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |output, value|
        Hirb::View.view_or_page_output(value) || @old_print.call(output, value)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end

%w(c n s).each { |command| Pry::Commands.delete(command) }
