import gi
gi.require_version('Gtk', '3.0')

from gi.repository import Gtk
from .globals import UIS_PATH
from .persons_form import PersonsFom

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


class MainWindow(Gtk.ApplicationWindow):

    """
    Class that inherits of Gtk.ApplicationWindow and that represents the main window application
    """

    def __init__(self, app):
        super().__init__(application=app)

        self.builder = Gtk.Builder.new_from_file(UIS_PATH + 'main_window.xml')

        self.set_titlebar(self.builder.get_object('mw_headerbar'))
        self.add(self.builder.get_object('mw_main_vbox'))

        stack = self.builder.get_object('mw_main_stack')
        stack.add_titled(PersonsFom(self), 'persons_form', 'Gestão de Pessoas')

        sidebar = Gtk.StackSidebar()
        sidebar.set_stack(stack)
        sidebar.set_size_request(200, -1)
        mw_main_hbox = self.builder.get_object('mw_main_hbox')
        mw_main_hbox .pack_start(sidebar, expand=False, fill=True, padding=0)
        mw_main_hbox.reorder_child(sidebar, 0)
