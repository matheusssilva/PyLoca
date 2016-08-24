import gi
gi.require_version('Gtk', '3.0')

from gi.repository import Gtk, Gio, Gdk
from .global_constants import IMGS_PATH, UIS_PATH
from . import persons_window

#MAKING THE MAIN WINDOW#
def make(app):
    builder = Gtk.Builder.new_from_file(UIS_PATH + 'main_window.xml')
    main_window = builder.get_object('main_window')
    main_menu_icon = builder.get_object('main_menu_icon')
    main_menu_button = builder.get_object('main_menu_button')
    logout_button = builder.get_object('logout_button')
    main_vbox_layout = builder.get_object('main_vbox_layout')

    main_menu = _MainMenu()

    #ACTIONS#
    persons_action = Gio.SimpleAction.new('persons', None)
    persons_action.connect('activate', _persons_action_func)
    main_window.add_action(persons_action)

    main_menu_button.add(main_menu_icon)
    main_menu_button.set_menu_model(main_menu)

    main_stack = Gtk.Stack.new()
    main_stack.set_hexpand(True)
    main_stack.set_vexpand(True)
    main_stack.set_name('main_stack')

    main_vbox_layout.pack_start(main_stack, expand=True, fill=True, padding=0)

    #HEADERBAR#
    main_headerbar = Gtk.HeaderBar()
    main_headerbar.set_show_close_button(True)
    main_headerbar.pack_start(main_menu_button)
    main_headerbar.pack_end(logout_button)
    main_window.set_titlebar(main_headerbar)

    # STYLING#
    css_provider = Gtk.CssProvider.new()
    css_provider.load_from_file(
        Gio.File.new_for_path(UIS_PATH + 'application.css'))
    Gtk.StyleContext.add_provider_for_screen(Gdk.Screen.get_default(
    ), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)

    main_window.set_application(app)
    main_window.maximize()
    main_window.show_all()

#ACTION FUNCTIONS#
def _persons_action_func(action, parameter):
    persons_window.make()


#CUSTOM COMPONENTES#
class _MainMenu(Gio.Menu):

    def __init__(self):
        super().__init__()

        menu_section_data = Gio.Menu.new()
        menu_section_conf = Gio.Menu.new()
        menu_section_actions = Gio.Menu.new()

        #MENUITEMS#
        persons_main_menuitem = Gio.MenuItem.new(
            'Gestão de _Pessoas               Alt+P', 'win.persons')
        stock_main_menuitem = Gio.MenuItem.new(
            'Gestão de Estoque', 'win.stock')
        trans_main_menuitem = Gio.MenuItem.new(
            'Gestão de _Transações          Alt+T', 'win.transactions')
        reports_main_menuitem = Gio.MenuItem.new(
            'Emissão de Relatórios', 'win.reports')
        configs_main_menuitem = Gio.MenuItem.new(
            'Configurações', 'win.configs')
        exit_main_menuitem = Gio.MenuItem.new('Sair', 'app.exit')

        #SETTING ICONS#
        persons_main_menuitem.set_icon(Gio.FileIcon.new(
            Gio.File.new_for_path(IMGS_PATH + 'persons.png')))
        stock_main_menuitem.set_icon(Gio.FileIcon.new(
            Gio.File.new_for_path(IMGS_PATH + 'stock.png')))
        trans_main_menuitem.set_icon(Gio.FileIcon.new(
            Gio.File.new_for_path(IMGS_PATH + 'transactions.png')))
        reports_main_menuitem.set_icon(Gio.FileIcon.new(
            Gio.File.new_for_path(IMGS_PATH + 'reports.png')))
        configs_main_menuitem.set_icon(Gio.FileIcon.new(
            Gio.File.new_for_path(IMGS_PATH + 'configs.png')))

        #INSERTING MENUITENS#
        menu_section_data.append_item(persons_main_menuitem)
        menu_section_data.append_item(stock_main_menuitem)
        menu_section_data.append_item(trans_main_menuitem)
        menu_section_data.append_item(reports_main_menuitem)
        self.append_section(None, menu_section_data)
        menu_section_conf.append_item(configs_main_menuitem)
        self.append_section(None, menu_section_conf)
        menu_section_actions.append_item(exit_main_menuitem)
        self.append_section(None, menu_section_actions)
