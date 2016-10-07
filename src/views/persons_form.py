"""
This module contains the persons form
"""

import gi
gi.require_version('Gtk', '3.0')

from others import inout
from .globals import UIS_PATH
from .globals import get_treeview_header_button as get_trvw_headerbtt
from .globals import load_configs_to_widgets as load_configs
from .globals import ImgChooserBttWithCapture
from gi.repository import Gtk

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


class PersonsFom(Gtk.Box):
    """
    Class that inherits of Gtk.Box and that contains all persons form component
    """

    def __init__(self, parent):
        super().__init__(orientation=Gtk.Orientation.VERTICAL)

        self.builder = Gtk.Builder.new_from_file(UIS_PATH + 'form_persons.xml')

        # ImageChooserButton
        img_chser_btt = ImgChooserBttWithCapture(inout.get_configs_file(
            'pyloca.config')['external_apps']['webcam_app'], parent)

        img_chser_btt.set_margin_bottom(10)

        fp_entries_vbox = self.builder.get_object('fp_entries_vbox')
        fp_entries_vbox.pack_start(
            img_chser_btt, expand=False, fill=True, padding=0)

        fp_entries_vbox.reorder_child(img_chser_btt, 1)

        # Get widgets for button [NEW]
        cleanable_widgets = [img_chser_btt] + [wid for wid in self.builder.get_objects() if type(wid) in (
            Gtk.Entry, Gtk.SearchEntry, Gtk.RadioButton, Gtk.ComboBox, Gtk.Switch, Gtk.CheckButton, Gtk.FileChooserButton)]

        # Configuring columns of table
        columns_of_table = {widget.get_name(): widget for widget in self.builder.get_objects(
        ) if type(widget) is Gtk.TreeViewColumn}

        for button in [get_trvw_headerbtt(columns_of_table[key]) for key in columns_of_table]:
            button.connect('button-press-event', self._on_col_btts_right_clicked,
                           self.builder.get_object('fp_table_columns_menu'))

        load_configs([wid for wid in columns_of_table.values() if wid.get_name(
        ) != 'fp_name_table_treevwcol'], Gtk.TreeViewColumn.set_visible, 'persons_columns', 'pyloca.config')

        # Configuring add/remove columns menu
        load_configs([wid for wid in self.builder.get_objects() if type(
            wid) is Gtk.CheckMenuItem], Gtk.CheckMenuItem.set_active, 'persons_columns_menu', 'pyloca.config')

        self.pack_start(self.builder.get_object('fp_notebook'), expand=True, fill=True, padding=0)

        spec_person_stack = self.builder.get_object('fp_spec_person_stack')

        # Dictionary of handlers
        self.dict_handlers = {
            'onClientBttToggled': (self._on_any_specifc_person_radbtt_tog, spec_person_stack, 'fp_client_grid'),
            'onDependentBttToggled': (self._on_any_specifc_person_radbtt_tog, spec_person_stack, 'fp_dependent_grid'),
            'onFunctionaryBttToggled': (self._on_any_specifc_person_radbtt_tog, spec_person_stack, 'fp_functionary_root_chkbtt'),
            'onPhone1ColMitemToggled': (self._on_mitem_cols_menu_toggled,
                                        columns_of_table['fp_phone1_table_treevwcol']),
            'onPhone2ColMitemToggled': (self._on_mitem_cols_menu_toggled,
                                        columns_of_table['fp_phone2_table_treevwcol']),
            'onEmailColMitemToggled': (self._on_mitem_cols_menu_toggled, columns_of_table['fp_email_table_treevwcol']),
            'onZipcodeColMitemToggled': (self._on_mitem_cols_menu_toggled, columns_of_table['fp_zipcode_table_treevwcol']),
            'onStateColMitemToggled': (self._on_mitem_cols_menu_toggled, columns_of_table['fp_state_table_treevwcol']),
            'onCityColMitemToggled': (self._on_mitem_cols_menu_toggled, columns_of_table['fp_city_table_treevwcol']),
            'onNeighborColMitemToggled': (self._on_mitem_cols_menu_toggled, columns_of_table['fp_neighbor_table_treevwcol']),
            'onStreetColMitemToggled': (self._on_mitem_cols_menu_toggled,
                                        columns_of_table['fp_street_table_treevwcol']),
            'onNumberColMitemToggled': (self._on_mitem_cols_menu_toggled,
                                        columns_of_table['fp_number_table_treevwcol']),
            'onComplementColMitemToggled': (self._on_mitem_cols_menu_toggled, columns_of_table['fp_complement_table_treevwcol']),
            'onLoginColMitemToggled': (self._on_mitem_cols_menu_toggled, columns_of_table['fp_login_table_treevwcol']),
            'onNewButtonClicked': (self._on_new_button_clicked, cleanable_widgets)
        }

        self.builder.connect_signals(self.dict_handlers)

    # Handlers
    def _on_any_specifc_person_radbtt_tog(self, button, stack, child_name):
        if button.get_active():
            stack.set_visible_child_name(child_name)

    def _on_col_btts_right_clicked(self, button, event, menu):
        if event.button == 3:
            menu.show_all()
            menu.popup(None, button, None, None, event.button, event.time)

    def _on_mitem_cols_menu_toggled(self, menuitem, column):
        column.set_visible(menuitem.get_active())

        configs = {
            'persons_columns': {
                column.get_name(): str(column.get_visible())
            },
            'persons_columns_menu': {
                menuitem.get_name(): str(menuitem.get_active())
            }
        }

        inout.set_configs_file('pyloca.config', configs)

    def _on_new_button_clicked(self, button, widgets):
        self._form_clear(widgets)

    def _on_find_button_clicked(self, button, searchbar):
        searchbar.set_search_mode(not searchbar.get_search_mode())

    # Internal functions
    def _form_clear(self, widgets):
        """
        Reset all widgets for a initial state
        """
        widget_type = None

        for widget in widgets:
            widget_type = type(widget)

            if widget_type is ImgChooserBttWithCapture:
                widget.unselect_all()
            elif widget_type in (Gtk.Entry, Gtk.SearchEntry):
                widget.set_text('')
            elif widget_type is Gtk.Switch:
                widget.set_active(True)
            elif widget_type is Gtk.CheckButton:
                widget.set_active(False)
            elif widget_type is Gtk.ComboBox:
                widget.set_active(-1)
            elif widget_type is Gtk.RadioButton and (widget.get_name() == 'fp_cel_phone1_radbtt' or widget.get_name() == 'fp_cel_phone2_radbtt'):
                widget.set_active(True)
