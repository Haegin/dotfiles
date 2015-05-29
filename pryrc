# require 'colored'
# require 'bond'
# require 'pry-coolline'

# === Listing config ===
# Better colors - by default the headings for methods are too
# similar to method name colors leading to a "soup"
# These colors are optimized for use with Solarized scheme
# for your terminal
Pry.config.ls.separator = "\n" # new lines between methods
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

# == PLUGINS ===
# awesome_print gem: great syntax colorized printing
# look at ~/.aprc for more settings for awesome_print
require 'interactive_editor'
begin
  require 'rubygems'
  require 'awesome_print'
  # require 'awesome_print_colors'

  # AwesomePrint.defaults={
  #               :theme=>:solorized,
  #               :indent => 2,
  #               :sort_keys => true,
  #               :color => {
  #                 :args       => :greenish,
  #                 :array      => :pale,
  #                 :bigdecimal => :blue,
  #                 :class      => :yellow,
  #                 :date       => :greenish,
  #                 :falseclass => :red,
  #                 :fixnum     => :blue,
  #                 :float      => :blue,
  #                 :hash       => :pale,
  #                 :keyword    => :cyan,
  #                 :method     => :purpleish,
  #                 :nilclass   => :red,
  #                 :string     => :yellowish,
  #                 :struct     => :pale,
  #                 :symbol     => :cyanish,
  #                 :time       => :greenish,
  #                 :trueclass  => :green,
  #                 :variable   => :cyanish
  #             }
  #          }



  # AwesomePrint.defaults={:theme=>:solorized}

  begin
    require 'pry-clipboard'
    # aliases
    Pry.config.commands.alias_command 'ch', 'copy-history'
    Pry.config.commands.alias_command 'cr', 'copy-result'
  rescue LoadError => e
    warn "can't load pry-clipboard"
    #       end'
  end


  # The following line enables awesome_print for all pry output,
  # and it also enables paging
  Pry.config.print = proc {|output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)}

  # If you want awesome_print without automatic pagination, use the line below
  # Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError => err
  puts "gem install awesome_print  # <-- highly recommended"
end

%w(c n s).each { |command| Pry::Commands.delete(command) }
