# config/report.rb

require 'dotenv/load'
require "prawn"
require 'time'
require 'rdoc/rdoc'

path = Dir.pwd + '/export/doc'
time = Time.now.utc.iso8601.tr(":", "")
report = "#{path}/hello_#{time}.pdf"

# Prawn::Document.generate(report) do
#     text "If you used the user password you won't be able to print the doc."
#  encrypt_document(:user_password => 'foo', :owner_password => 'bar',
#  :permissions => { :print_document => false })
# end

##
# This class represents an arbitrary shape by a series of points.

class Shape

    ##
    # Creates a new shape described by a +polyline+.
    #
    # If the +polyline+ does not end at the same point it started at the
    # first pointed is copied and placed at the end of the line.
    #
    # An ArgumentError is raised if the line crosses itself, but shapes may
    # be concave.
  
    def initialize polyline
      # ...
    end

    ##
    # Creates a new testing described by a +testing+.
    #
    def testing
        # ...
      end
  
  end