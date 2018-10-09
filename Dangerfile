# Variables
scheme = "CivicConnect-Example"
workspace = "CivicConnect.xcworkspace"
include_targets = "CivicConnect.framework"
minimum_coverage_percentage = 75.0
lint_directory = "CivicConnect"

# Setup
is_base_branch_master = github.branch_for_base == "master" 
is_head_branch_release = github.branch_for_head.include?("release/")

# Prevent merges from branches other than release
if is_base_branch_master and !is_head_branch_release
	fail "Branches can only be merged into master if they are from a release branch."
end

# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

# Don't let testing shortcuts get into master by accident
fail("xdescribe left in tests") if `grep -r xdescribe specs/ `.length > 1
fail("xit left in tests") if `grep -r xit specs/ `.length > 1

# Prevent a lower or the same tag being merged into master
if is_base_branch_master and is_head_branch_release
    latest_tag = `git describe origin/master --tags`.lines.last
    current_tag = github.branch_for_head.split("/")[1]
    if Gem::Version.new(latest_tag) > Gem::Version.new(current_tag)
        fail "Incorrect tag. Master tag #{latest_tag} | Release tag #{current_tag}."
    end
end

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
