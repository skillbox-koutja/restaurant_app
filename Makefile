codegen:
	fvm dart run build_runner build --delete-conflicting-outputs

codebuild:
	fvm dart run build_runner build

codegen-clean:
	@echo "* Cleaning build runner *"
	find . -type f -name "*.gr.dart" -delete
	find . -type f -name "*.g.dart" -delete
	find . -type f -name "*.freezed.dart" -delete

l10n:
	fvm flutter gen-l10n

cgc:
	make codegen-clean