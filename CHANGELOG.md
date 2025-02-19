# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [0.8.1] - 2019-09-27
### Added
- Running with the PARLOUR_DEBUG environment variable set will now print debug
output to the console during conflict resolution.

### Fixed
- Performance is now much faster when the conflict resolver needs to resolve a
conflict between many identical objects.

## [0.8.0] - 2019-09-14
### Added
- Methods can now have type parameters specified.

### Changed
- **Breaking change: The `implementation` qualifier is no longer genereated.**
Following Sorbet merging `implementation` and `override` into just `override`,
the `Method#implementation` and `Method#override` flags will now both generate 
the `override` qualifier.
- The Parlour codebase now uses `override` for both abstract implementation and
superclass overriding to conform to this change.

## [0.7.0] - 2019-09-11
### Added
- The strictness level can now be specified when generating an RBI, using an
optional positional argument to `RBIGenerator#generate`. The default strictness
is `strong`.
- Plugins can specify a strictness level they would prefer by setting
`Plugin#strictness` for themselves. If multiple plugins set conflicting 
strictnesses, the least strict will be used.
- Attributes can now specified as class attributes by setting
`Attribute#class_attribute` to `true`. This will wrap them in a `class << self`
block.

### Changed
- The `sorbet` directory is no longer included in the built gem.
- Generated files now end with a new line (`\n`).

### Fixed
- An instance method and a class method with the same name are no longer
considered conflicting.
- The signature for the constructor of `Attribute` previously typed the optional
initializer block as taking a `Method`. This has been corrected to taking an
`Attribute`.

## [0.6.1] - 2019-07-29
### Changed
- Various areas of the codebase have been made compatible with older Ruby
versions.

## [0.6.0] - 2019-07-25
### Changed
- **Breaking change: the `name: ` keyword argument is now positional instead.**
Instead of `create_method(name: 'A', returns: 'String')`, use
`create_method('A', returns: 'String')`.
- Altered some syntax to improve compatibility with previous Ruby versions.
(Full compatibility is still WIP.)

### Fixed
- Fixed some Sorbet type signatures.
- Fixed an RSpec warning.

## [0.5.2] - 2019-07-24
### Added
- Added the `Namespace#create_includes` and `Namespace#create_extends` methods
to add multiple `include` and `extend` calls at once.

### Changed
- Signatures for some methods using keyword parameters have been altered such
that those keywords are required. Previously, these parameters defaulted to
`nil`, and the Sorbet runtime would fail an assertion if they weren't present.

### Fixed
- Fixed some incorrect documentation for the `Namespace` methods `path` and
`create_constant`.
- Fixed a Sorbet signature for `Method#describe` which was causing an exception.

## [0.5.1] - 2019-07-21
### Added
- Added the `Namespace#path` method for plugins to use.

## [0.5.0] - 2019-07-20
### Added
- Added the `create_arbitrary` method for inserting arbitrary code into the
generated RBI file. This is intended for using constructs which Parlour does
not yet support.

### Changed
- Breaking change: `add_constant`, `add_include` and `add_extend` have been
replaced with `create_constant`, `create_include` and `create_extend`.

## [0.4.0] - 2019-07-10
### Changed
- Breaking change: The Parlour CLI tool no longer takes command-line arguments, and instead uses a `.parlour` configuration file. See the README!
- RBIs now begin with `# typed: strong`.
- Plugins now define a stub constructor to avoid an exception if they don't define one.

## [0.3.1] - 2019-07-09
### Changed
- Multi-line parameter lists no longer have a trailing comma.

## [0.3.0] - 2019-07-09
### Changed
- Breaking change: all `Namespace#create_` methods, and the `Parameter` constructor, now take entirely keyword arguments.
  For example, `create_method('A', [], 'String')` is now written as `create_method(name: 'A', returns: 'String')`.

## [0.2.2] - 2019-07-08
### Fixed
- Fixed a bug which occasionally caused includes and extends to generate incorrectly.

## [0.2.1] - 2019-07-08
### Added
- Added the `add_comment_to_next_child` method to namespaces.

## [0.2.0] - 2019-07-07
### Added
- Add support for plugins using the `parlour` command-line tool.
- Comments can now be added using `add_comment`.
- Attribute readers, writers and accessors can now be created, using the `create_attr_...` methods.
- All objects are now YARD documented.

### Changed
- The `RbiObject`, which is core to Parlour's internals, is now an abstract class rather than an interface.
- `ConflictResolver` now recurses to child namespaces.
- `create_method` now takes an initializer block like other `create_` methods.

## [0.1.1] - 2019-07-05
### Added
- Initial release!

_(0.1.0 was a blank gem.)_