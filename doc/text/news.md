# News

## 7.0.0 - 2021-12-20 {#version-7-0-0}

### Improvements

  * Dropped support for Rails 5.1.

  * Added support for Rails 7.0.

  * Added support for deep `sub_test_case`.
    [GitHub#24][Reported by Akira Matsuda]

### Thanks

  * Akira Matsuda

## 6.1.0 - 2021-01-13 {#version-6-1-0}

### Improvements

  * Added support for Rails 6.1.
    [GitHub#23][Reported by Shugo Maeda]

### Thanks

  * Shugo Maeda

## 6.0.0 - 2019-07-11 {#version-6-0-0}

### Improvements

  * Added support for Rails 6.0.

  * Stopped to load `test_helper.rb`.

## 5.2.2 - 2018-08-20 {#version-5-2-2}

### Improvements

  * Added support for Rails 5.1 without Puma.
    [GitHub#21][Patch by neko maho]

### Thanks

  * neko maho

## 5.2.1 - 2018-08-10 {#version-5-2-1}

### Improvements

  * Added support for `ActionDispatch::SystemTestCase`.
    [GitHub#20][Patch by okkez]

### Thanks

  * okkez

## 5.1.3 - 2017-07-28 {#version-5-1-3}

### Improvements

  * Removed test-unit-notify dependency.

  * Added `test:system` task support.
    [GitHub#17][Patch by naofumi-fujii]

### Thanks

  * naofumi-fujii

## 5.1.2 - 2017-07-05 {#version-5-1-2}

### Improvements

  * Updated document.
    [GitHub#12][Patch by Haruka Yoshihara]

  * Migrated document markup to Markdown from Textile.
    [GitHub#13][Patch by Haruka Yoshihara]

  * Supported Rails 5.1.2.
    [GitHub#14][Reported by naofumi-fujii]

### Thanks

  * Haruka Yoshihara

  * naofumi-fujii

## 5.0.5 - 2016-12-20 {#version-5-0-5}

### Improvements

  * Required test-unit-activesupport 1.0.8 or later.

## 5.0.4 - 2016-12-20 {#version-5-0-4}

### Fixes

  * Supported Rails 4 again.
    [GitHub#11][Patch by Akira Matsuda]

### Thanks

  * Akira Matsuda

## 5.0.3 - 2016-12-19 {#version-5-0-3}

### Improvements

  * Converted documents to Markdown from Textile.
    [GitHub#10][Patch by takiy33]

  * Supported `file_fixture`.

### Thanks

  * takiy33

## 5.0.2 - 2016-06-28 {#version-5-0-2}

### Improvements

  * Supported Rails applications that don't use Active Record.
    [GitHub#8][Patch by Akira Matsuda]

### Fixes

  * Fixed test failure. [Reported by Shita Koyanagi]

### Thanks

  * Shita Koyanagi

  * Akira Matsuda

## 5.0.1 - 2016-02-27 {#version-5-0-1}

### Fixes

  * Added missing files to gem. [GitHub#7][Patch by y-yagi]

### Thanks

  * y-yagi

## 5.0.0 - 2016-01-18 {#version-5-0-0}

Rails 5 support release.

### Improvements

  * Supported Rails 5.
  * Required Rails 4 or later explicitly.
    [GitHub#5][Patch by Charles Lowell]

### Thanks

  * Charles Lowell

## 1.0.4 - 2014-09-07 {#version-1-0-4}

Bug fixes release.

### Fixes

  * Used the correct class to be extended for running tests by `Test::Unit` .
    `ActiveSupport::TestCase` is used now but before `Test::Unit::TestCase` was.
    `ActiveSupport::TestCase` (but `TestUnit::TestCase` ) is inherited
    by `ActionController::TestCase` (for controller tests) and
    `ActionDispatch::IntegrationTest` (for integration tests).

## 1.0.3 - 2014-09-04 {#version-1-0-3}

### Improvements

  * Supported Rails 4.0.0.
    After this version, test-unit-rails requires test-unit-activesupport
    1.0.2 or later.
    In this version, test-unit-rails drops to support rails 3.2.16 or older.
    If you want to use this gem with Rails 3.2.16 or older, please use
    1.0.2 version.

## 1.0.2 - 2012-07-05 {#version-1-0-2}

### Improvements

  * Supported Bundler 1.2.0.pre.1.
    [GitHub#1] [Reported by Michael D.W. Prendergast]

### Thanks

  * Michael D.W. Prendergast

## 1.0.1 - 2012-06-03 {#version-1-0-1}

### Improvements

  * Extracted ActiveSupport related codes into test-unit-activesupport
    gem and depended on it.

## 1.0.0 - 2012-1-2 {#version-1-0-0}

The first release!!!
