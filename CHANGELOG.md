### 2.2.2

* Added `onBeforeSearch` callback to `NiceBaseListSearchBar`.

### 2.2.1

* Fix `NiceAuth` listeners triggering too often

## 2.2.0

* Deprecate `NiceBaseListBody.emptyStateBuilder` in favor of `NiceBaseListEmptyState`

### 2.1.1

* Fix for introduction screen

### 2.1.0

* Add NiceLocalizations extension (`context.translate("key")`)

### 2.1.0-rc.2

* Fix worst base list typings

### 2.1.0-rc.1

* Upgrade dart sdk min version to 3.0.0

### 2.0.1

* Fix inverted condition in `NiceBaseListCubit.removeValuesWhere`
* Add loading opacity to `NiceBaseListLoading`

### 2.0.0

* Apply lints

### 2.0.0-rc.2

* Fixed typings for NiceAuth (form 1.4.20)

### 2.0.0-rc.1

RC for version 2.

* Major base list refactor.
* Dart 3 changes.
* Added some utils.

---

### 1.4.22

* Fix for base list

### 1.4.21

* Lints

### 1.4.20

* Fixed typings for NiceAuth

### 1.4.19

* Added padding to `NiceOnboarding`.

### 1.4.18

* Added safearea in `NiceOnboarding`.

### 1.4.17

* Changed deprecated background theme color usage in onboarding.
* Dart 3.0 deprecation warning fixes

### 1.4.16

* Changed onboarding to comply with Apple's guideline

### 1.4.15

* Added `NiceLocalizationsConfig`

### 1.4.14

* Upgrade firebase version

### 1.4.13

* Page view form: pressing back when on first page will now pop

### 1.4.12

* Onboarding layout fixes

### 1.4.11

* Added absorb pointer and opacity overlay to NiceLoadingOverlay.

### 1.4.10

* Added a NiceSignInConfig with the autofillEmailAndPassword argument to NiceSignIn

### 1.4.9

* Minor UI improvements
*

### 1.4.8

* Added the `loading` option to the `NiceBaseListCubit.load` method.

### 1.4.7

* Remove "raw" argument and move it to a new function.

### 1.4.6

* Added "raw" argument to NiceLocalizations' translate method to return translation as a json object
  if a node is reached instead of a leaf.

### 1.4.5

* Update dependencies

### 1.4.4

* Added batch method to NiceFutureUtils

### 1.4.3

* Update dependencies

### 1.4.2

* Added loadOnInit callback to the NiceBaseList

### 1.4.1

* Fixes for Flutter 3.0

### 1.4.0

* Added onCubitCreated callback to NiceBaseList
* Added onChanged callback to RadioExpandable & RadioExpandableCard

## 1.3.0

* Added RadioExpandableProvider
* Added RadioExpandable
* Added RadioExpandableCard

## 1.2.0

* Added NiceFutureUtils

## 1.1.0

* Added NicePageViewForm
* Added NiceCaseUtils
* Added NiceJwtUtils
* Added NiceAuth
* Added NiceSignIn

## 1.0.0

* Initial release
