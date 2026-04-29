# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_lx_global_optspecs
	string join \n dev server= extra-servers= only-sources= namespace= lua-dir= lua-version= tree= cache-dir= data-dir= vendor-dir= variables= verbose no-progress no-prompt nvim timeout= max-jobs= no-luarc h/help V/version
end

function __fish_lx_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_lx_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_lx_using_subcommand
	set -l cmd (__fish_lx_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c lx -n "__fish_lx_needs_command" -l server -d 'Fetch rocks/rockspecs from this server (takes priority over config file)' -r
complete -c lx -n "__fish_lx_needs_command" -l extra-servers -d 'Fetch rocks/rockspecs from this server in addition to the main server{n} (overrides any entries in the config file)' -r
complete -c lx -n "__fish_lx_needs_command" -l only-sources -d 'Restrict downloads to paths matching the given URL' -r
complete -c lx -n "__fish_lx_needs_command" -l namespace -d 'Specify the luarocks server namespace to use' -r
complete -c lx -n "__fish_lx_needs_command" -l lua-dir -d 'Specify the directory in which to install Lua{n} if not found' -r -F
complete -c lx -n "__fish_lx_needs_command" -l lua-version -d 'Which Lua installation to use.{n} Valid versions are: \'5.1\', \'5.2\', \'5.3\', \'5.4\', \'jit\' and \'jit52\'' -r
complete -c lx -n "__fish_lx_needs_command" -l tree -d 'Which tree to operate on' -r -F
complete -c lx -n "__fish_lx_needs_command" -l cache-dir -d 'Specifies the cache directory for e.g. luarocks manifests' -r -F
complete -c lx -n "__fish_lx_needs_command" -l data-dir -d 'Specifies the data directory (e.g. ~/.local/share/lux)' -r -F
complete -c lx -n "__fish_lx_needs_command" -l vendor-dir -d 'Specifies a directory with locally vendored sources and RockSpecs.{n} When building or installing a package with this flag,{n} Lux will fetch sources from the <vendor-dir> instead of from a remote server' -r -F
complete -c lx -n "__fish_lx_needs_command" -l variables -d 'Override config variables.{n} Example: `lx -v "LUA=/path/to/lua" ...`' -r
complete -c lx -n "__fish_lx_needs_command" -l timeout -d 'Timeout on network operations, in seconds.{n} 0 means no timeout (wait forever). Default is 30' -r
complete -c lx -n "__fish_lx_needs_command" -l max-jobs -d 'Maximum buffer size for parallel jobs, such as downloading rockspecs and installing rocks. 0 means no limit. Default is 0' -r
complete -c lx -n "__fish_lx_needs_command" -l dev -d 'Enable the sub-repositories in luarocks servers for rockspecs of in-development versions'
complete -c lx -n "__fish_lx_needs_command" -l verbose -d 'Display verbose output of commands executed'
complete -c lx -n "__fish_lx_needs_command" -l no-progress -d 'Don\'t print any progress bars or spinners'
complete -c lx -n "__fish_lx_needs_command" -l no-prompt -d 'Skip prompts, selecting the default option'
complete -c lx -n "__fish_lx_needs_command" -l nvim -d 'Configure lux for installing Neovim packages'
complete -c lx -n "__fish_lx_needs_command" -l no-luarc -d 'Do not generate or update a `.luarc.json` file when building{n} a project'
complete -c lx -n "__fish_lx_needs_command" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_needs_command" -s V -l version -d 'Print version'
complete -c lx -n "__fish_lx_needs_command" -f -a "add" -d 'Add a dependency to the current project'
complete -c lx -n "__fish_lx_needs_command" -f -a "build" -d 'Build/compile a project'
complete -c lx -n "__fish_lx_needs_command" -f -a "check" -d '[EXPERIMENTAL]{n} Type check the current project based on EmmyLua/LuaCATS annotations.{n} Respects `.emmyrc.json` and `.luarc.json` files in the project directory'
complete -c lx -n "__fish_lx_needs_command" -f -a "config" -d 'Interact with the lux configuration'
complete -c lx -n "__fish_lx_needs_command" -f -a "completion" -d 'Generate autocompletion scripts for the shell.{n} Example: `lx completion zsh > ~/.zsh/completions/_lx`'
complete -c lx -n "__fish_lx_needs_command" -f -a "debug" -d 'Internal commands for debugging Lux itself'
complete -c lx -n "__fish_lx_needs_command" -f -a "doc" -d 'Show documentation for an installed rock'
complete -c lx -n "__fish_lx_needs_command" -f -a "download" -d 'Download a specific rock file from a luarocks server'
complete -c lx -n "__fish_lx_needs_command" -f -a "fmt" -d 'Formats the codebase with stylua'
complete -c lx -n "__fish_lx_needs_command" -f -a "generate-rockspec" -d 'Generate a rockspec file from a project'
complete -c lx -n "__fish_lx_needs_command" -f -a "info" -d 'Show metadata for any rock'
complete -c lx -n "__fish_lx_needs_command" -f -a "install" -d 'Install a rock for use on the system'
complete -c lx -n "__fish_lx_needs_command" -f -a "install-rockspec" -d 'Install a local rockspec for use on the system'
complete -c lx -n "__fish_lx_needs_command" -f -a "install-lua" -d 'Manually install and manage Lua headers for various Lua versions'
complete -c lx -n "__fish_lx_needs_command" -f -a "lint" -d 'Lint the current project using `luacheck`'
complete -c lx -n "__fish_lx_needs_command" -f -a "list" -d 'List currently installed rocks'
complete -c lx -n "__fish_lx_needs_command" -f -a "lua" -d 'Run lua, with the `LUA_PATH` and `LUA_CPATH` set to the specified lux tree'
complete -c lx -n "__fish_lx_needs_command" -f -a "new" -d 'Create a new Lua project'
complete -c lx -n "__fish_lx_needs_command" -f -a "outdated" -d 'List outdated rocks'
complete -c lx -n "__fish_lx_needs_command" -f -a "pack" -d 'Create a packed rock for distribution, packing sources or binaries'
complete -c lx -n "__fish_lx_needs_command" -f -a "path" -d 'Return the currently configured package path'
complete -c lx -n "__fish_lx_needs_command" -f -a "pin" -d 'Pin an existing rock, preventing any updates to the package'
complete -c lx -n "__fish_lx_needs_command" -f -a "purge" -d 'Remove all installed rocks from a tree'
complete -c lx -n "__fish_lx_needs_command" -f -a "remove" -d 'Remove a rock from the current project\'s lux.toml dependencies'
complete -c lx -n "__fish_lx_needs_command" -f -a "run" -d 'Run the current project with the provided arguments'
complete -c lx -n "__fish_lx_needs_command" -f -a "exec" -d 'Execute a command that has been installed with lux. If the command is not found, a package named after the command will be installed'
complete -c lx -n "__fish_lx_needs_command" -f -a "search" -d 'Query the luarocks servers'
complete -c lx -n "__fish_lx_needs_command" -f -a "test" -d 'Run the test suite in the current project directory.{n} Lux supports the following test backends, specified by the `[test]` table in the lux.toml:{n} {n} - busted:{n} {n} https://lunarmodules.github.io/busted/{n} {n} Example:{n} {n} ```toml{n} [test]{n} type = "busted"{n} flags = [ ] # Optional CLI flags to pass to busted{n} ```{n} {n} `lx test` will default to using `busted` if no test backend is specified and:{n} * there is a `.busted` file in the project root{n} * or `busted` is one of the `test_dependencies`).{n} {n} - busted-nlua:{n}: {n} [currently broken on Windows]{n} A build backend for running busted tests with Neovim as the Lua interpreter. Used for testing Neovim plugins. {n} Example:{n} {n} ```toml{n} [test]{n} type = "busted-nlua"{n} flags = [ ] # Optional CLI flags to pass to busted{n} ```{n} {n} `lx test` will default to using `busted-nlua` if no test backend is specified and:{n} * there is a `.busted` file in the project root{n} * or `busted` and `nlua` are `test_dependencies`.{n} {n} - command:{n} {n} Name/file name of a shell command that will run the test suite.{n} Example:{n} {n} ```toml{n} [test]{n} type = "command"{n} command = "make"{n} flags = [ "test" ]{n} ```{n} {n} - script:{n} {n} Relative path to a Lua script that will run the test suite.{n} Example:{n} {n} ```toml{n} [test]{n} type = "script"{n} script = "tests.lua" # Expects a tests.lua file in the project root{n} flags = [ ] # Optional arguments passed to the test script{n} ```{n}'
complete -c lx -n "__fish_lx_needs_command" -f -a "uninstall" -d 'Uninstall a rock from the system'
complete -c lx -n "__fish_lx_needs_command" -f -a "unpin" -d 'Unpins an existing rock, allowing updates to alter the package'
complete -c lx -n "__fish_lx_needs_command" -f -a "update" -d 'Updates all rocks in a project'
complete -c lx -n "__fish_lx_needs_command" -f -a "upload" -d 'Generate a Lua rockspec for a Lux project and upload it to the public luarocks repository.{n} You can specify a source template for release and dev packages in the lux.toml.{n} {n} Example:{n} {n} ```toml{n} [source]{n} url = "https://host.com/owner/$(PACKAGE)/refs/tags/$(REF).zip"{n} dev = "git+https://host.com/owner/$(PACKAGE).git"{n} ```{n} {n} You can use the following variables in the source template:{n} {n} - $(PACKAGE): The package name.{n} - $(VERSION): The package version.{n} - $(REF): The git tag or revision (if in a git repository).{n} - You may also specify environment variables with `$(<VAR_NAME>)`.{n} {n} If the `version` is not set in the lux.toml, lux will search the current commit for SemVer tags and if found, will use it to generate the package version'
complete -c lx -n "__fish_lx_needs_command" -f -a "vendor" -d 'Vendor the dependencies of a project or RockSpec locally. When building or installing a package with the `--vendor-dir` option{n} or the `[vendor_dir]` config option, Lux will fetch sources from the <vendor-dir>{n} instead of from a remote server'
complete -c lx -n "__fish_lx_needs_command" -f -a "which" -d 'Tell which file corresponds to a given module name'
complete -c lx -n "__fish_lx_needs_command" -f -a "shell" -d 'Spawns an interactive shell with PATH, LUA_PATH, LUA_CPATH and LUA_INIT set'
complete -c lx -n "__fish_lx_needs_command" -f -a "sync" -d 'Synchronize the project tree with the current lux.toml,{n} ensuring all packages are installed correctly'
complete -c lx -n "__fish_lx_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c lx -n "__fish_lx_using_subcommand add" -s b -s d -s b -l build -d 'Install the package as a development dependency. {n} Also called `dev`' -r
complete -c lx -n "__fish_lx_using_subcommand add" -s t -s t -l test -d 'Install the package as a test dependency' -r
complete -c lx -n "__fish_lx_using_subcommand add" -l force -d 'Reinstall without prompt if a package is already installed'
complete -c lx -n "__fish_lx_using_subcommand add" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand build" -l no-lock -d 'Ignore the project\'s lockfile and don\'t create one'
complete -c lx -n "__fish_lx_using_subcommand build" -l only-deps -d 'Build only the dependencies'
complete -c lx -n "__fish_lx_using_subcommand build" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand check" -s i -l ignore -d 'Comma-separated list of ignore patterns. Patterns must follow glob syntax. Lux will automatically add top-level ignored project files' -r
complete -c lx -n "__fish_lx_using_subcommand check" -l output-format -d 'The output format' -r -f -a "json\t''
text\t''"
complete -c lx -n "__fish_lx_using_subcommand check" -l output -d 'Output destination.{n} (stdout or a file path, only used when the output format is json)' -r
complete -c lx -n "__fish_lx_using_subcommand check" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c lx -n "__fish_lx_using_subcommand check" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand config; and not __fish_seen_subcommand_from init edit show help" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand config; and not __fish_seen_subcommand_from init edit show help" -f -a "init" -d 'Initialise a new config file'
complete -c lx -n "__fish_lx_using_subcommand config; and not __fish_seen_subcommand_from init edit show help" -f -a "edit" -d 'Edit the current config file'
complete -c lx -n "__fish_lx_using_subcommand config; and not __fish_seen_subcommand_from init edit show help" -f -a "show" -d 'Show the current config. This includes options picked up from CLI flags'
complete -c lx -n "__fish_lx_using_subcommand config; and not __fish_seen_subcommand_from init edit show help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c lx -n "__fish_lx_using_subcommand config; and __fish_seen_subcommand_from init" -l default -d 'Initialise the default config for this system. If this flag is not set, an empty config file will be created'
complete -c lx -n "__fish_lx_using_subcommand config; and __fish_seen_subcommand_from init" -l current -d 'Initialise the config file using the current config, with options picked up from CLI flags'
complete -c lx -n "__fish_lx_using_subcommand config; and __fish_seen_subcommand_from init" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand config; and __fish_seen_subcommand_from edit" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand config; and __fish_seen_subcommand_from show" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand config; and __fish_seen_subcommand_from help" -f -a "init" -d 'Initialise a new config file'
complete -c lx -n "__fish_lx_using_subcommand config; and __fish_seen_subcommand_from help" -f -a "edit" -d 'Edit the current config file'
complete -c lx -n "__fish_lx_using_subcommand config; and __fish_seen_subcommand_from help" -f -a "show" -d 'Show the current config. This includes options picked up from CLI flags'
complete -c lx -n "__fish_lx_using_subcommand config; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c lx -n "__fish_lx_using_subcommand completion" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand debug; and not __fish_seen_subcommand_from unpack fetch-remote unpack-remote project help" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand debug; and not __fish_seen_subcommand_from unpack fetch-remote unpack-remote project help" -f -a "unpack" -d 'Unpack the contents of a rock'
complete -c lx -n "__fish_lx_using_subcommand debug; and not __fish_seen_subcommand_from unpack fetch-remote unpack-remote project help" -f -a "fetch-remote" -d 'Fetch a remote rock from its RockSpec source'
complete -c lx -n "__fish_lx_using_subcommand debug; and not __fish_seen_subcommand_from unpack fetch-remote unpack-remote project help" -f -a "unpack-remote" -d 'Download a .src.rock from luarocks.org and unpack it'
complete -c lx -n "__fish_lx_using_subcommand debug; and not __fish_seen_subcommand_from unpack fetch-remote unpack-remote project help" -f -a "project" -d 'View information about the current project'
complete -c lx -n "__fish_lx_using_subcommand debug; and not __fish_seen_subcommand_from unpack fetch-remote unpack-remote project help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c lx -n "__fish_lx_using_subcommand debug; and __fish_seen_subcommand_from unpack" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand debug; and __fish_seen_subcommand_from fetch-remote" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand debug; and __fish_seen_subcommand_from unpack-remote" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand debug; and __fish_seen_subcommand_from project" -l list-files -d 'List files that are included. To avoid copying large files that are not relevant to the build process, Lux excludes hidden files and files that are ignored (e.g. by .gitignore or other .ignore files)'
complete -c lx -n "__fish_lx_using_subcommand debug; and __fish_seen_subcommand_from project" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand debug; and __fish_seen_subcommand_from help" -f -a "unpack" -d 'Unpack the contents of a rock'
complete -c lx -n "__fish_lx_using_subcommand debug; and __fish_seen_subcommand_from help" -f -a "fetch-remote" -d 'Fetch a remote rock from its RockSpec source'
complete -c lx -n "__fish_lx_using_subcommand debug; and __fish_seen_subcommand_from help" -f -a "unpack-remote" -d 'Download a .src.rock from luarocks.org and unpack it'
complete -c lx -n "__fish_lx_using_subcommand debug; and __fish_seen_subcommand_from help" -f -a "project" -d 'View information about the current project'
complete -c lx -n "__fish_lx_using_subcommand debug; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c lx -n "__fish_lx_using_subcommand doc" -l online -d 'Ignore local docs and open the package\'s homepage in a browser'
complete -c lx -n "__fish_lx_using_subcommand doc" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand download" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand fmt" -l backend -r -f -a "stylua\t''
emmylua-codestyle\t''"
complete -c lx -n "__fish_lx_using_subcommand fmt" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand generate-rockspec" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand info" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand install" -l pin -d 'Pin the packages so that they don\'t get updated'
complete -c lx -n "__fish_lx_using_subcommand install" -l force -d 'Reinstall without prompt if a package is already installed'
complete -c lx -n "__fish_lx_using_subcommand install" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand install-rockspec" -l pin -d 'Whether to pin the installed package and dependencies'
complete -c lx -n "__fish_lx_using_subcommand install-rockspec" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand install-lua" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand lint" -l no-ignore -d 'By default, Lux will add top-level ignored files and directories{n} (like those in .gitignore) to luacheck\'s exclude files.{n} This flag disables that behaviour.{n}'
complete -c lx -n "__fish_lx_using_subcommand lint" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand list" -l porcelain
complete -c lx -n "__fish_lx_using_subcommand list" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand lua" -l lua -d 'Path to the Lua interpreter to use' -r
complete -c lx -n "__fish_lx_using_subcommand lua" -l test -d 'Add test dependencies to the environment'
complete -c lx -n "__fish_lx_using_subcommand lua" -l build -d 'Add build dependencies to the environment'
complete -c lx -n "__fish_lx_using_subcommand lua" -l no-loader -d 'Disable the Lux loader. If a rock has conflicting transitive dependencies, disabling the Lux loader may result in the wrong modules being loaded'
complete -c lx -n "__fish_lx_using_subcommand lua" -l no-lock -d 'Ignore the project\'s lockfile and don\'t create one'
complete -c lx -n "__fish_lx_using_subcommand lua" -l only-deps -d 'Build only the dependencies'
complete -c lx -n "__fish_lx_using_subcommand lua" -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand new" -l name -d 'The project\'s name' -r
complete -c lx -n "__fish_lx_using_subcommand new" -l description -d 'The description of the project' -r
complete -c lx -n "__fish_lx_using_subcommand new" -l license -d 'The license of the project. Generic license names will be inferred' -r
complete -c lx -n "__fish_lx_using_subcommand new" -l maintainer -d 'The maintainer of this project. Does not have to be the code author' -r
complete -c lx -n "__fish_lx_using_subcommand new" -l labels -d 'A comma-separated list of labels to apply to this project' -r
complete -c lx -n "__fish_lx_using_subcommand new" -l lua-versions -d 'A version constraint on the required Lua version for this project. Examples: ">=5.1", "5.1"' -r
complete -c lx -n "__fish_lx_using_subcommand new" -l main -r -f -a "src\t''
lua\t''"
complete -c lx -n "__fish_lx_using_subcommand new" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand outdated" -l porcelain
complete -c lx -n "__fish_lx_using_subcommand outdated" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand pack" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand path; and not __fish_seen_subcommand_from full lua c bin init help" -l prepend -d 'Prepend the rocks tree paths to the system paths'
complete -c lx -n "__fish_lx_using_subcommand path; and not __fish_seen_subcommand_from full lua c bin init help" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand path; and not __fish_seen_subcommand_from full lua c bin init help" -f -a "full" -d 'Generate an export statement for all paths (formatted as a shell command). [Default]'
complete -c lx -n "__fish_lx_using_subcommand path; and not __fish_seen_subcommand_from full lua c bin init help" -f -a "lua" -d 'Generate a `LUA_PATH` expression for `lua` libraries in the lux tree. (not formatted as a shell command)'
complete -c lx -n "__fish_lx_using_subcommand path; and not __fish_seen_subcommand_from full lua c bin init help" -f -a "c" -d 'Generate a `LUA_CPATH` expression for native `lib` libraries in the lux tree. (not formatted as a shell command)'
complete -c lx -n "__fish_lx_using_subcommand path; and not __fish_seen_subcommand_from full lua c bin init help" -f -a "bin" -d 'Generate a `PATH` expression for `bin` executables in the lux tree. (not formatted as a shell command)'
complete -c lx -n "__fish_lx_using_subcommand path; and not __fish_seen_subcommand_from full lua c bin init help" -f -a "init" -d 'Generate a `LUA_INIT` expression for the lux loader. (not formatted as a shell command)'
complete -c lx -n "__fish_lx_using_subcommand path; and not __fish_seen_subcommand_from full lua c bin init help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from full" -l shell -d 'The shell to format for' -r -f -a "posix\t''
fish\t''
nu\t''"
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from full" -l no-bin -d 'Do not export `PATH` (`bin` paths)'
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from full" -l no-loader -d 'Do not add `require(\'lux\').loader()` to `LUA_INIT`. If a rock has conflicting transitive dependencies, disabling the Lux loader may result in the wrong modules being loaded'
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from full" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from lua" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from c" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from bin" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from init" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from help" -f -a "full" -d 'Generate an export statement for all paths (formatted as a shell command). [Default]'
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from help" -f -a "lua" -d 'Generate a `LUA_PATH` expression for `lua` libraries in the lux tree. (not formatted as a shell command)'
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from help" -f -a "c" -d 'Generate a `LUA_CPATH` expression for native `lib` libraries in the lux tree. (not formatted as a shell command)'
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from help" -f -a "bin" -d 'Generate a `PATH` expression for `bin` executables in the lux tree. (not formatted as a shell command)'
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from help" -f -a "init" -d 'Generate a `LUA_INIT` expression for the lux loader. (not formatted as a shell command)'
complete -c lx -n "__fish_lx_using_subcommand path; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c lx -n "__fish_lx_using_subcommand pin" -s b -s d -s b -l build -d 'Pin a development dependency. Also called `dev`' -r
complete -c lx -n "__fish_lx_using_subcommand pin" -s t -l test -d 'Pin a test dependency' -r
complete -c lx -n "__fish_lx_using_subcommand pin" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand purge" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand remove" -s b -s d -s b -l build -d 'Remove a development dependency. Also called `dev`' -r
complete -c lx -n "__fish_lx_using_subcommand remove" -s t -l test -d 'Remove a test dependency' -r
complete -c lx -n "__fish_lx_using_subcommand remove" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand run" -l dir -d 'Path in which to run the command.{n} Defaults to the project root' -r -F
complete -c lx -n "__fish_lx_using_subcommand run" -l no-loader -d 'Do not add `require(\'lux\').loader()` to `LUA_INIT`.{n} If a rock has conflicting transitive dependencies,{n} disabling the Lux loader may result in the wrong modules being loaded'
complete -c lx -n "__fish_lx_using_subcommand run" -l no-lock -d 'Ignore the project\'s lockfile and don\'t create one'
complete -c lx -n "__fish_lx_using_subcommand run" -l only-deps -d 'Build only the dependencies'
complete -c lx -n "__fish_lx_using_subcommand run" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand exec" -l no-loader -d 'Do not add `require(\'lux\').loader()` to `LUA_INIT`. If a rock has conflicting transitive dependencies, disabling the Lux loader may result in the wrong modules being loaded'
complete -c lx -n "__fish_lx_using_subcommand exec" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand search" -l porcelain -d 'Return a machine readable format'
complete -c lx -n "__fish_lx_using_subcommand search" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand test" -l impure -d 'Don\'t isolate the user environment (keep `HOME` and `XDG` environment variables)'
complete -c lx -n "__fish_lx_using_subcommand test" -l no-lock -d 'Ignore the project\'s lockfile and don\'t create one'
complete -c lx -n "__fish_lx_using_subcommand test" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand uninstall" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand unpin" -s b -s d -s b -l build -d 'Pin a development dependency. Also called `dev`' -r
complete -c lx -n "__fish_lx_using_subcommand unpin" -s t -l test -d 'Pin a test dependency' -r
complete -c lx -n "__fish_lx_using_subcommand unpin" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand update" -s b -s d -s b -l build -d 'Build dependencies to update. Also called `dev`. When used with the --toml flag in a project, these must be package names' -r
complete -c lx -n "__fish_lx_using_subcommand update" -s t -l test -d 'Build dependencies to update. When used with the --toml flag in a project, these must be package names' -r
complete -c lx -n "__fish_lx_using_subcommand update" -l no-integrity-check -d 'Skip the integrity checks for installed rocks when syncing the project lockfile'
complete -c lx -n "__fish_lx_using_subcommand update" -l toml -d 'Upgrade packages in the project\'s lux.toml (if operating on a project)'
complete -c lx -n "__fish_lx_using_subcommand update" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand upload" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand vendor" -l rockspec -d 'RockSpec to vendor the packages for.{n} If not set, Lux will vendor dependencies of the current project' -r -F
complete -c lx -n "__fish_lx_using_subcommand vendor" -l no-lock -d 'Ignore the project\'s lockfile, if present'
complete -c lx -n "__fish_lx_using_subcommand vendor" -l no-delete -d 'Don\'t delete the <vendor-dir> when vendoring,{n} but rather keep all existing contents of the vendor directory'
complete -c lx -n "__fish_lx_using_subcommand vendor" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand which" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand shell" -l test -d 'Add test dependencies to the shell\'s paths,{n} in addition to the regular dependencies'
complete -c lx -n "__fish_lx_using_subcommand shell" -l build -d 'Add *only* build dependencies to the shell\'s paths'
complete -c lx -n "__fish_lx_using_subcommand shell" -l no-loader -d 'Disable the Lux loader.{n} If a rock has conflicting transitive dependencies,{n} disabling the Lux loader may result in the wrong modules being loaded.{n}'
complete -c lx -n "__fish_lx_using_subcommand shell" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand sync" -l no-integrity-check -d 'Skip the integrity checks for installed rocks when syncing the project lockfile'
complete -c lx -n "__fish_lx_using_subcommand sync" -s h -l help -d 'Print help'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "add" -d 'Add a dependency to the current project'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "build" -d 'Build/compile a project'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "check" -d '[EXPERIMENTAL]{n} Type check the current project based on EmmyLua/LuaCATS annotations.{n} Respects `.emmyrc.json` and `.luarc.json` files in the project directory'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "config" -d 'Interact with the lux configuration'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "completion" -d 'Generate autocompletion scripts for the shell.{n} Example: `lx completion zsh > ~/.zsh/completions/_lx`'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "debug" -d 'Internal commands for debugging Lux itself'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "doc" -d 'Show documentation for an installed rock'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "download" -d 'Download a specific rock file from a luarocks server'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "fmt" -d 'Formats the codebase with stylua'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "generate-rockspec" -d 'Generate a rockspec file from a project'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "info" -d 'Show metadata for any rock'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "install" -d 'Install a rock for use on the system'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "install-rockspec" -d 'Install a local rockspec for use on the system'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "install-lua" -d 'Manually install and manage Lua headers for various Lua versions'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "lint" -d 'Lint the current project using `luacheck`'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "list" -d 'List currently installed rocks'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "lua" -d 'Run lua, with the `LUA_PATH` and `LUA_CPATH` set to the specified lux tree'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "new" -d 'Create a new Lua project'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "outdated" -d 'List outdated rocks'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "pack" -d 'Create a packed rock for distribution, packing sources or binaries'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "path" -d 'Return the currently configured package path'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "pin" -d 'Pin an existing rock, preventing any updates to the package'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "purge" -d 'Remove all installed rocks from a tree'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "remove" -d 'Remove a rock from the current project\'s lux.toml dependencies'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "run" -d 'Run the current project with the provided arguments'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "exec" -d 'Execute a command that has been installed with lux. If the command is not found, a package named after the command will be installed'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "search" -d 'Query the luarocks servers'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "test" -d 'Run the test suite in the current project directory.{n} Lux supports the following test backends, specified by the `[test]` table in the lux.toml:{n} {n} - busted:{n} {n} https://lunarmodules.github.io/busted/{n} {n} Example:{n} {n} ```toml{n} [test]{n} type = "busted"{n} flags = [ ] # Optional CLI flags to pass to busted{n} ```{n} {n} `lx test` will default to using `busted` if no test backend is specified and:{n} * there is a `.busted` file in the project root{n} * or `busted` is one of the `test_dependencies`).{n} {n} - busted-nlua:{n}: {n} [currently broken on Windows]{n} A build backend for running busted tests with Neovim as the Lua interpreter. Used for testing Neovim plugins. {n} Example:{n} {n} ```toml{n} [test]{n} type = "busted-nlua"{n} flags = [ ] # Optional CLI flags to pass to busted{n} ```{n} {n} `lx test` will default to using `busted-nlua` if no test backend is specified and:{n} * there is a `.busted` file in the project root{n} * or `busted` and `nlua` are `test_dependencies`.{n} {n} - command:{n} {n} Name/file name of a shell command that will run the test suite.{n} Example:{n} {n} ```toml{n} [test]{n} type = "command"{n} command = "make"{n} flags = [ "test" ]{n} ```{n} {n} - script:{n} {n} Relative path to a Lua script that will run the test suite.{n} Example:{n} {n} ```toml{n} [test]{n} type = "script"{n} script = "tests.lua" # Expects a tests.lua file in the project root{n} flags = [ ] # Optional arguments passed to the test script{n} ```{n}'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "uninstall" -d 'Uninstall a rock from the system'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "unpin" -d 'Unpins an existing rock, allowing updates to alter the package'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "update" -d 'Updates all rocks in a project'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "upload" -d 'Generate a Lua rockspec for a Lux project and upload it to the public luarocks repository.{n} You can specify a source template for release and dev packages in the lux.toml.{n} {n} Example:{n} {n} ```toml{n} [source]{n} url = "https://host.com/owner/$(PACKAGE)/refs/tags/$(REF).zip"{n} dev = "git+https://host.com/owner/$(PACKAGE).git"{n} ```{n} {n} You can use the following variables in the source template:{n} {n} - $(PACKAGE): The package name.{n} - $(VERSION): The package version.{n} - $(REF): The git tag or revision (if in a git repository).{n} - You may also specify environment variables with `$(<VAR_NAME>)`.{n} {n} If the `version` is not set in the lux.toml, lux will search the current commit for SemVer tags and if found, will use it to generate the package version'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "vendor" -d 'Vendor the dependencies of a project or RockSpec locally. When building or installing a package with the `--vendor-dir` option{n} or the `[vendor_dir]` config option, Lux will fetch sources from the <vendor-dir>{n} instead of from a remote server'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "which" -d 'Tell which file corresponds to a given module name'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "shell" -d 'Spawns an interactive shell with PATH, LUA_PATH, LUA_CPATH and LUA_INIT set'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "sync" -d 'Synchronize the project tree with the current lux.toml,{n} ensuring all packages are installed correctly'
complete -c lx -n "__fish_lx_using_subcommand help; and not __fish_seen_subcommand_from add build check config completion debug doc download fmt generate-rockspec info install install-rockspec install-lua lint list lua new outdated pack path pin purge remove run exec search test uninstall unpin update upload vendor which shell sync help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c lx -n "__fish_lx_using_subcommand help; and __fish_seen_subcommand_from config" -f -a "init" -d 'Initialise a new config file'
complete -c lx -n "__fish_lx_using_subcommand help; and __fish_seen_subcommand_from config" -f -a "edit" -d 'Edit the current config file'
complete -c lx -n "__fish_lx_using_subcommand help; and __fish_seen_subcommand_from config" -f -a "show" -d 'Show the current config. This includes options picked up from CLI flags'
complete -c lx -n "__fish_lx_using_subcommand help; and __fish_seen_subcommand_from debug" -f -a "unpack" -d 'Unpack the contents of a rock'
complete -c lx -n "__fish_lx_using_subcommand help; and __fish_seen_subcommand_from debug" -f -a "fetch-remote" -d 'Fetch a remote rock from its RockSpec source'
complete -c lx -n "__fish_lx_using_subcommand help; and __fish_seen_subcommand_from debug" -f -a "unpack-remote" -d 'Download a .src.rock from luarocks.org and unpack it'
complete -c lx -n "__fish_lx_using_subcommand help; and __fish_seen_subcommand_from debug" -f -a "project" -d 'View information about the current project'
complete -c lx -n "__fish_lx_using_subcommand help; and __fish_seen_subcommand_from path" -f -a "full" -d 'Generate an export statement for all paths (formatted as a shell command). [Default]'
complete -c lx -n "__fish_lx_using_subcommand help; and __fish_seen_subcommand_from path" -f -a "lua" -d 'Generate a `LUA_PATH` expression for `lua` libraries in the lux tree. (not formatted as a shell command)'
complete -c lx -n "__fish_lx_using_subcommand help; and __fish_seen_subcommand_from path" -f -a "c" -d 'Generate a `LUA_CPATH` expression for native `lib` libraries in the lux tree. (not formatted as a shell command)'
complete -c lx -n "__fish_lx_using_subcommand help; and __fish_seen_subcommand_from path" -f -a "bin" -d 'Generate a `PATH` expression for `bin` executables in the lux tree. (not formatted as a shell command)'
complete -c lx -n "__fish_lx_using_subcommand help; and __fish_seen_subcommand_from path" -f -a "init" -d 'Generate a `LUA_INIT` expression for the lux loader. (not formatted as a shell command)'
