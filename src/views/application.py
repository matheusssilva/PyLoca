import gi
gi.require_version('Gtk', '3.0')

import sys
from gi.repository import Gtk, Gio
from views.main_window import MainWindow


class _Application(Gtk.Application):

    def do_activate(self):
        MainWindow(self).show_all()

    def do_startup(self):
        Gtk.Application.do_startup(self)

        #ACTIONS#
        exit_action = Gio.SimpleAction.new('exit', None)

        #CONNECTING ACTIONS#
        exit_action.connect('activate', self.exit_action_function)

        #ADDING ACTIONS#
        self.add_action(exit_action)

    def exit_action_function(self, action, parameter):
        self.quit()


def run():
    app = _Application()
    app_status = app.run(sys.argv)
    sys.exit(app_status)
