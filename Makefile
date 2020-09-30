#########################
##	GENERAL SETTINGS   ##
#########################

# Color code
BOLD_B=\033[1m
BOLD_E=\033[0m
RED=\033[0;31m
GREEN=\033[0;32m
NC=\033[0m

# Macro for better display
PRINT_NAME=@printf "%50s\t" $<
PRINT_STATUS=@if [ $$? -eq 0 ]; then echo -e '$(GREEN)$(BOLD_B)[SUCCESS]$(BOLD_E)$(NC)'; else echo -e '$(RED)$(BOLD_B)[FAIL]$(BOLD_E)$(NC)'; fi
PRINT_PROCESS_NAME=@printf "\n%50s\t" $@

# Name of source, include and object folder (relative to Makefile path)
SOURCES_DIR=src
INCLUDE_DIR=include
OBJECTS_DIR=bin

# Reference to source and object files.
SOURCES=$(wildcard $(SOURCES_DIR)/*.c)
OBJECTS=$(patsubst $(SOURCES_DIR)/%.c,$(OBJECTS_DIR)/%.o,$(SOURCES))

#########################
##  PROJECT SETTINGS   ##
#########################

# THIS PART HAS TO BE MODIFIED IN ORDER TO FIT YOUR PROJECT. CHECK README FOR MORE INFORMATION.

# Compiler
CXX= clang

# Compilation flags (-c for .o object generation)
CXXFLAGS= -c -Wall -Wextra

# Module ARSDK3
INCLUDE_MODULE_ARSDK3= /home/kiwi/Sandbox/ParrotSDK/out/arsdk-native/staging/usr/include
LINK_MODULE_ARSDK3= /home/kiwi/Sandbox/ParrotSDK/out/arsdk-native/staging/usr/lib
LIB_MODULE_ARSDK3= -lardiscovery -lardiscovery -larsal -larcontroller -larnetworkal -larcommands -lmux -lpomp -ljson -larstream -larnetwork -lulog -lrtsp -larstream2 -lsdp -lfutils -larmedia

# Module NCURSES
INCLUDE_MODULE_NCURSES=
LINK_MODULE_NCURSES=
LIB_MODULE_NCURSES= -lcurses

# Include and link/lib flags composed of INCLUDE_DIR (default) and modules defined previously
INCLUDE_FLAGS= -I$(INCLUDE_DIR) -I$(INCLUDE_MODULE_ARSDK3)
LDFLAGS=-L$(LINK_MODULE_ARSDK3) $(LIB_MODULE_ARSDK3) $(LIB_MODULE_NCURSES)

# Name of the executable/library
PROCESS_NAME= BebopApplication

# Logfile containing compilation log
LOGFILE=build.log

##################
##  BUILD STEP  ##
##################

.PHONY: all
.ONESHELL:
all: compil

.PHONY: debug
.ONESHELL:
debug: CXXFLAGS += -g
debug: compil

compil: CLEAN_BEFORE_BUILD $(PROCESS_NAME)

.PHONY: clean
clean: CLEAN_BEFORE_BUILD
	@rm -f $(OBJECTS)


$(PROCESS_NAME): $(OBJECTS)
	@$(PRINT_PROCESS_NAME)
	@$(CXX) $(LDFLAGS) $^ -o $@  >> $(LOGFILE) 2>&1
	@$(PRINT_STATUS)

$(OBJECTS_DIR)/%.o: $(SOURCES_DIR)/%.c
	@$(PRINT_NAME)
	@$(CXX) $(CXXFLAGS) $(INCLUDE_FLAGS) $< -o $@ >> $(LOGFILE) 2>&1
	@$(PRINT_STATUS)

CLEAN_BEFORE_BUILD:
	@rm -f $(LOGFILE)
	@rm -f $(PROCESS_NAME)
	@if [ ! -d "$(OBJECTS_DIR)" ]; then
	@	mkdir $(OBJECTS_DIR)
	@fi
