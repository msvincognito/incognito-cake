BISC_MASS=280
COCOA_MASS=20
MARGARINE_MASS=120 # Make sure this is melted. This is a requirement for this makefile to work.
COFFEE_MASS=20
ICING_SUGAR_MASS=150
ICE_WATER_MASS=150

all: link
	# eat the cake
	echo clean_surface/cake.tin > /dev/null
	rm clean_surface/cake.tin && touch clean_surface/cake.tin
	clear

furnish_kitchen:
	mkdir -p oven clean_surface fridge microwave
	echo 0 > oven/temperature

# oven is assumed to be a unix file descriptor whose heat can be controlled
# by a file inside called temperature
ground: furnish_kitchen
	mkdir -p clean_surface fridge
	echo 180 > oven/temperature
	rm -f clean_surface/cake.tin && touch clean_surface/cake.tin
	echo "Biscuit $(BISC_MASS)g" >> clean_surface/cake.tin
	echo "Cocoa powder $(COCOA_MASS)g" >> clean_surface/cake.tin
	echo "Margarine $(MARGARINE_MASS)g" >> clean_surface/cake.tin
	mv clean_surface/cake.tin fridge
	sleep 10m
	mv fridge/cake.tin oven
	sleep 15m
	mv oven/cake.tin clean_surface
    
creme: furnish_kitchen
	mkdir -p clean_surface
	touch clean_surface/bowl
	echo "Coffee $(COFFEE_MASS)g" >> clean_surface/bowl
	echo "Icing sugar $(ICING_SUGAR_MASS)g" >> clean_surface/bowl
	echo "Ice water $(ICE_WATER_MASS)ml" >> clean_surface/bowl
	shuf clean_surface/bowl > clean_surface/bowl
	shuf clean_surface/bowl > clean_surface/bowl
	shuf clean_surface/bowl > clean_surface/bowl
    
link: ground creme
	cat clean_surface/* > clean_surface/cake.tin
	rm clean_surface/bowl
	mv clean_surface/cake.tin fridge
	sleep 1h
	mv fridge/cake.tin clean_surface
