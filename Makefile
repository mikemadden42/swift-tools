SWIFT_FILES := $(wildcard *.swift)
EXECUTABLES := $(SWIFT_FILES:.swift=)

SWIFTC := swiftc
LIPO := lipo
STRIP := strip

SWIFT_FLAGS := -O -whole-module-optimization
X86_64_TARGET := x86_64-apple-macosx10.15
ARM64_TARGET := arm64-apple-macosx11.0

.PHONY: all clean

all: $(EXECUTABLES)

%: %.swift
	$(SWIFTC) $(SWIFT_FLAGS) -target $(X86_64_TARGET) -o $@_x86_64 $<
	$(SWIFTC) $(SWIFT_FLAGS) -target $(ARM64_TARGET) -o $@_arm64 $<
	$(LIPO) -create -output $@_unstripped $@_x86_64 $@_arm64
	$(STRIP) -o $@ $@_unstripped
	rm $@_x86_64 $@_arm64 $@_unstripped
	@echo "Built and stripped universal binary: $@"

clean:
	rm -f $(EXECUTABLES)
