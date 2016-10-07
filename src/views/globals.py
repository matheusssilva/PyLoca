"""
This module contains views global functions
"""

import gi
import subprocess

gi.require_version('Gtk', '3.0')

from gi.repository import Gtk, GdkPixbuf
from gi.repository.GLib import GError
from others import inout

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


IMGS_PATH = 'views/uis/images/'
UIS_PATH = 'views/uis/'


def get_treeview_header_button(column):
    """
    Receive a Gtk.TreeViewColumn object and return its reader button
    """

    widget = column.get_widget()
    parent = widget

    while parent.get_name() != 'GtkButton':
        widget = parent
        parent = widget.get_parent()

    return parent


def load_configs_to_widgets(widgets, set_function, section, file_name):
    """
    Load configurations from config files end apply the given function to given widgets.
    The configfile section must be supplied from [section] parameter

    [widgets] is a widget list
    [set_function] is the function to be applied to each element
    [section] is a configfile section
    [file_name] is the configs file name
    """
    configs = inout.get_configs_file(file_name)

    for widget in widgets:
        set_function(widget, configs.getboolean(section, widget.get_name()))



class ImgChooserBttWithCapture(Gtk.FileChooserButton):
    """
    The custom Gtk.FileChooserButton and Gtt.FileChooserDialog with a button for call capture app
    """

    def __init__(self, cap_app_path, parent):
        self.builder = Gtk.Builder.new_from_file(
            UIS_PATH + 'images_chooser_dialog.xml')

        self.chooser_dialog = self.builder.get_object('icd_photo_chsrdialog')
        self.chooser_dialog.set_transient_for(parent)

        super().__init__(dialog=self.chooser_dialog)
        cap_app_path = cap_app_path
        self.set_title('Selecione uma imagem')
        self.set_halign(Gtk.Align.START)
        self.set_valign(Gtk.Align.FILL)
        self.set_hexpand(True)
        self.set_tooltip_text('Clique para escolher uma nova imagem')
        self.set_local_only(False)

        handlers = {
            'onCaptureButtonClicked': (self._on_capture_button_clicked, cap_app_path),
            'onDialogClosed': self._on_file_chooser_dialog_closed, 
            'onUpdatePreview': self._on_update_preview
        }

        self.connect('button-release-event', self._on_chooser_file_btt_clicked)
        self.builder.connect_signals(handlers)

    def _on_capture_button_clicked(self, button, cap_app_path):

        try:
            subprocess.call([cap_app_path])
        except (subprocess.CalledProcessError, subprocess.TimeoutExpired, FileNotFoundError) as ex:

            self.builder.add_from_file(UIS_PATH + 'information_window.xml')
            msg_dialog = self.builder.get_object('iw_messagedialog')

            msg_dialog.set_title('Erro')
            msg_dialog.set_markup(
                '<span size="12000"><b>Não foi possível abrir o aplicativo</b></span>')

            msg_dialog.format_secondary_markup(
                'O aplicativo de captura não está disponível.\nVerifique o caminho para o aplicativo de caputura em configurações.\n' + '<span foreground="red"><u>' + str(ex) + '</u></span>')

            msg_dialog.set_property('message-type', Gtk.MessageType.ERROR)
            msg_dialog.set_transient_for(self.chooser_dialog)
            self.builder.get_object('iw_message_image').set_from_file(
                'views/uis/images/message_error.png')

            msg_dialog.run()
            msg_dialog.destroy()

    def _on_update_preview(self, dialog):

        path = dialog.get_preview_filename()

        try:
            pixbuf = GdkPixbuf.Pixbuf.new_from_file(path)
        except (GError, OSError, IOError, TypeError) as ex:
            dialog.set_preview_widget_active(False)
        else:
            #scale the image
            maxwidth, maxheight = 300.0, 700.0 # as floats to avoid integer division in python2
            width, height = pixbuf.get_width(), pixbuf.get_height()
            scale = min(maxwidth/width, maxheight/height)

            if scale < 1:
                width, height = int(width * scale), int(height * scale)
                pixbuf = pixbuf.scale_simple(width, height, GdkPixbuf.InterpType.BILINEAR)

            dialog.get_preview_widget().set_from_pixbuf(pixbuf)
            dialog.set_preview_widget_active(True)
    
    def _on_chooser_file_btt_clicked(self, button, event):
        self.chooser_dialog.get_transient_for().set_sensitive(False)
    
    def _on_file_chooser_dialog_closed(self, dialog):
        self.chooser_dialog.get_transient_for().set_sensitive(True)
