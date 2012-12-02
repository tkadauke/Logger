#
#  AppDelegate.rb
#  Logger
#
#  Created by Thomas Kadauke on 02.12.12.
#  Copyright 2012 Thomas Kadauke. All rights reserved.
#

require 'socket'

class AppDelegate
  attr_accessor :window
  attr_accessor :table_view
  
  def awakeFromNib
    @data = []
    
    @server = TCPServer.open(2000)
    Thread.start do
      loop do
        Thread.start(@server.accept) do |client|
          while line = client.gets
            @data << [Time.now.to_s, line.chop]
            table_view.reloadData
          end
          client.close
        end
      end
    end
  end
  
  def numberOfRowsInTableView(tableView)
    @data.size
  end
  
  def tableView(tableView, objectValueForTableColumn:column, row:row)
    data_row = @data[row]
    case column.identifier
    when 'timestamp'
      data_row[0]
    when 'message'
      data_row[1]
    end
  end
  
  def clear(sender)
    @data = []
    table_view.reloadData
  end

  def copy(sender)
    rows_to_copy = []
    table_view.selectedRowIndexes.enumerateIndexesUsingBlock lambda { |index, dummy| rows_to_copy << @data[index][1] }
    pasteboard = NSPasteboard.generalPasteboard
    changeCount = pasteboard.clearContents
    pasteboard.writeObjects(rows_to_copy)
  end
end
