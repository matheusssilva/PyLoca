import gi
gi.require_version('Gtk', '3.0')

from gi.repository import Gtk
from .global_constants import IMGS_PATH, UIS_PATH

#MAKING THE PERSONS_WINDOW#
def make():
    builder = Gtk.Builder.new_from_file(UIS_PATH + 'form_persons.xml')
    persons_window = builder.get_object('persons_window')
    persons_window.show_all()