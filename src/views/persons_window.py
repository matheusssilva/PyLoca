import gi
gi.require_version('Gtk', '3.0')

from gi.repository import Gtk
from .global_constants import UIS_PATH


#MAKING THE PERSONS_WINDOW#
def make():
    builder = Gtk.Builder.new()

    builder.add_from_file(UIS_PATH + 'form_persons.xml')
    builder.add_from_file(UIS_PATH + 'form_persons_subwindows.xml')

    persons_window = builder.get_object('fp_window')
    fp_specific_hbox = builder.get_object('fp_specific_hbox')
    fp_client_hbox = builder.get_object('fp_client_hbox')
    fp_dependent_hbox = builder.get_object('fp_dependent_hbox')
    fp_functionary_root_chkbtt = builder.get_object(
        'fp_functionary_root_chkbtt')
    fpsw_table_columns_menu = builder.get_object('fpsw_table_columns_menu')

    specific_person_stack = Gtk.Stack.new()
    specific_person_stack.add_named(fp_client_hbox, 'fp_client_hbox')
    specific_person_stack.add_named(fp_dependent_hbox, 'fp_dependent_hbox')
    specific_person_stack.add_named(
        fp_functionary_root_chkbtt, 'fp_functionary_root_chkbtt')

    specific_person_stack.set_transition_type(
        Gtk.StackTransitionType.SLIDE_LEFT_RIGHT)
    specific_person_stack.set_transition_duration(600)

    fp_specific_hbox.pack_start(
        specific_person_stack, expand=True, fill=True, padding=0)

    #GETTING COLUMNS AND HEADER BUTTONS OBJECTS OF TABLE#
    columns_of_table = {widget.get_name(): widget for widget in builder.get_objects(
    ) if type(widget) is Gtk.TreeViewColumn}

    buttons_of_columns = [_get_table_header_button(
        columns_of_table[key]) for key in columns_of_table]

    for button in buttons_of_columns:
        button.connect('button-press-event',
                       _on_col_btts_right_clicked, fpsw_table_columns_menu)

    dict_handlers = {
        'onClientBttToggled': (_on_client_radbtt_toggled, specific_person_stack),
        'onDependentBttToggled': (_on_dependent_radbtt_toggled, specific_person_stack),
        'onFunctionaryBttToggled': (_on_functionary_radbtt_toggled, specific_person_stack),
        'onNameColMitemToggled': (_on_mitem_cols_menu_toggled, columns_of_table['fp_name_table_treevwcol']),
        'onPhone1ColMitemToggled': (_on_mitem_cols_menu_toggled, columns_of_table['fp_phone1_table_treevwcol']),
        'onPhone2ColMitemToggled': (_on_mitem_cols_menu_toggled, columns_of_table['fp_phone2_table_treevwcol']),
        'onEmailColMitemToggled': (_on_mitem_cols_menu_toggled, columns_of_table['fp_email_table_treevwcol']),
        'onZipcodeColMitemToggled': (_on_mitem_cols_menu_toggled, columns_of_table['fp_zipcode_table_treevwcol']),
        'onStateColMitemToggled': (_on_mitem_cols_menu_toggled, columns_of_table['fp_state_table_treevwcol']),
        'onCityColMitemToggled': (_on_mitem_cols_menu_toggled, columns_of_table['fp_city_table_treevwcol']),
        'onNeighborColMitemToggled': (_on_mitem_cols_menu_toggled, columns_of_table['fp_neighbor_table_treevwcol']),
        'onStreetColMitemToggled': (_on_mitem_cols_menu_toggled, columns_of_table['fp_street_table_treevwcol']),
        'onNumberColMitemToggled': (_on_mitem_cols_menu_toggled, columns_of_table['fp_number_table_treevwcol']),
        'onComplementColMitemToggled': (_on_mitem_cols_menu_toggled, columns_of_table['fp_complement_table_treevwcol']),
        'onLoginColMitemToggled': (_on_mitem_cols_menu_toggled, columns_of_table['fp_login_table_treevwcol'])
    }

    builder.connect_signals(dict_handlers)
    persons_window.show_all()


#HANDLERS#
def _on_client_radbtt_toggled(button, stack):
    if button.get_active():
        stack.set_visible_child_name('fp_client_hbox')


def _on_dependent_radbtt_toggled(button, stack):
    if button.get_active():
        stack.set_visible_child_name('fp_dependent_hbox')


def _on_functionary_radbtt_toggled(button, stack):
    if button.get_active():
        stack.set_visible_child_name('fp_functionary_root_chkbtt')


def _on_col_btts_right_clicked(button, event, menu):
    if event.button == 3:
        menu.show_all()
        menu.popup(None, button, None, None, event.button, event.time)


def _on_mitem_cols_menu_toggled(menuitem, column):
    column.set_visible(menuitem.get_active())


#INTERNAL FUNCTIONS#
def _get_table_header_button(column):
    widget = column.get_widget()
    parent = widget

    while parent.get_name() != 'GtkButton':
        widget = parent
        parent = widget.get_parent()

    return parent
