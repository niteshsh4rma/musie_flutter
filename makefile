setup:
	fvm flutter clean && fvm flutter pub get

clean:
	fvm flutter clean

translations:
	fvm flutter gen-l10n

generate:
	fvm flutter pub run build_runner build --delete-conflicting-outputs

# Feel free to add more commands