# Variables
scheme = "CivicConnect-Example"
workspace = "CivicConnect.xcworkspace"
include_targets = "CivicConnect.framework"
minimum_coverage_percentage = 75.0
lint_directory = "CivicConnect"

# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

# Report the code coverage percentage
xcov.report(
   scheme: scheme,
   workspace: workspace,
   include_targets: include_targets,
   minimum_coverage_percentage: minimum_coverage_percentage,
   disable_coveralls: true
)

# Check the linting of the directory
if lint_directory
  swiftlint.directory = lint_directory
end

swiftlint.config_file = '.swiftlint.yml'
swiftlint.lint_files inline_mode: true
