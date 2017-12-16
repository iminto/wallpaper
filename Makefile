VALAC = valac

PKG =   --pkg=libsoup-2.4 \
	--pkg=posix \
	--pkg=gio-2.0 \
	--pkg=json-glib-1.0 \
	--pkg gtk+-3.0 \
	--pkg gmodule-2.0

SRC =   ./src/GetScreen.vala \
		./src/Bing.vala \
		./src/Dir.vala \
		./App.vala

BIN = wallpaper

all:
	$(VALAC) $(PKG) $(SRC) $(OPTIONS)  -o $(BIN)
