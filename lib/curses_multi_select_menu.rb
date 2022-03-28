# frozen_string_literal: true
require 'curses_menu'

module CursesMultiSelectMenu     
   LineSelect = Struct.new('LineSelect', :line, :selected);
   private_constant :LineSelect;

   private_class_method def self.drawCheckBox(lineSelect)
      if lineSelect.selected then
         return "[x] #{lineSelect.line}";
      end
      return "[ ] #{lineSelect.line}";
   end

   def self.invoke(messagePrompt, lines)
      lss = lines.map{ |line| LineSelect.new(line, false) }
      CursesMenu.new messagePrompt do |menu|
         lssLength = lss.length - 1
         lss.map!{ |ls|
            menu.item drawCheckBox ls do
               ls.selected = !ls.selected;
               :menu_refresh
            end
            ls
         }
         menu.item "==> Confirm <==" do
            :menu_exit
            return lss.select{ |ls| ls.selected }.map{ |ls| ls.line }
         end
         menu.item "==>  Abort  <==" do
            :menu_exit
            return []
         end
      end
   end

end
