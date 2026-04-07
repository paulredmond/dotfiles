require 'mkmf'
require 'fileutils'

class String
    def red;   "\033[31m#{self}\033[0m" end
    def green; "\033[32m#{self}\033[0m" end
    def yellow; "\033[33m#{self}\033[0m" end
end

def get_excludes
  exclude  = %w(.git .gitignore README.md Rakefile mkmf.log SublimeText iterm gnome Fonts doc bin bat)

  if (File.exists?('.gitignore'))
    File.open('.gitignore', 'r').each_line do |line|
      exclude.push(line) unless exclude.include? line
    end
  end

  exclude
end

exclude = get_excludes
def root_dir
  File.dirname(__FILE__)
end

desc 'Install dotfiles'
task :install do

  current_dir = File.dirname(__FILE__)
  home = File.expand_path('~')
  Dir.foreach(current_dir) do |item|
    next if item  == '.' or item == '..' or exclude.include? item or item[0] == '.'
    src  = current_dir + "/#{item}"
    dest = home + "/.#{item}"
    File.symlink(src, dest) && puts("Symlinking #{dest} -> #{src}") unless File.symlink?(dest) || File.exists?(dest)
  end

  # Create an empty .zshrc.local
  if ! File.exists?(home + '/.zshrc.local')
    puts "Adding an empty .zshrc.local file for local modifications"
    local_zsh = File.new(home + '/.zshrc.local', "w")
    local_zsh.puts("# Local modifications")
    local_zsh.close
  end

  # Symlink scripts/t to ~/.local/bin/t
  local_bin = home + '/.local/bin'
  FileUtils.mkdir_p(local_bin)
  t_src  = current_dir + '/scripts/t'
  t_dest = local_bin + '/t'
  File.symlink(t_src, t_dest) && puts("Symlinking #{t_dest} -> #{t_src}") unless File.symlink?(t_dest) || File.exists?(t_dest)

  ocuskills_src  = current_dir + '/scripts/ocuskills-update'
  ocuskills_dest = local_bin + '/ocuskills-update'
  File.symlink(ocuskills_src, ocuskills_dest) && puts("Symlinking #{ocuskills_dest} -> #{ocuskills_src}") unless File.symlink?(ocuskills_dest) || File.exists?(ocuskills_dest)

  # Install bat config and themes
  bat_src = current_dir + '/bat'
  bat_dest = home + '/.config/bat'
  if Dir.exist?(bat_src)
    FileUtils.mkdir_p(bat_dest + '/themes')

    # Symlink config file
    config_src = bat_src + '/config'
    config_dest = bat_dest + '/config'
    if File.exist?(config_src) && !File.exist?(config_dest)
      File.symlink(config_src, config_dest)
      puts "Symlinking #{config_dest} -> #{config_src}"
    end

    # Copy theme files
    Dir.glob(bat_src + '/themes/*.tmTheme').each do |theme|
      dest = bat_dest + '/themes/' + File.basename(theme)
      unless File.exist?(dest)
        FileUtils.cp(theme, dest)
        puts "Installing bat theme #{File.basename(theme)}"
      end
    end

    if find_executable('bat')
      puts "Rebuilding bat cache..."
      system('bat cache --build')
    end
  end

  puts "Installation complete!"

end

namespace :homebrew do
  task :setup do

  end
  task :basic do
    basics = %w(rbenv ruby-build ack the_silver_searcher tig vim mercurial tmux)
    basics.each do |package|
      puts `brew install #{package}`
    end
  end
  task :lamp do
    # stub for lamp development requirements.
  end
end

namespace :composer do
  def composer_exists?
    File.exists?(composer_path)
  end

  # Get the composer path
  def composer_path
    "#{root_dir}/bin/composer"
  end
  desc 'Install composer binary'
  task :install do
    # Check if composer already available
    if composer_exists?
      puts "Composer is already installed at #{root_dir}/bin/composer"
      next
    end

    if !find_executable('php')
      puts "PHP Executable not found!"
      next
    end

    curl = find_executable('curl')

    if curl
      puts "Installing composer now..."
      puts `(cd #{root_dir}/bin && #{curl} -sS https://getcomposer.org/installer | php -- --filename=composer)`

      if File.exists?("#{root_dir}/bin/composer")
        puts "composer installed successfully."
      else
        puts "composer could not be installed properly with curl."
      end
    else
      puts "`curl` not available on this system.".yellow,
           "Using PHP directly to download and install..."
      puts `(cd #{root_dir}/bin && php -r "readfile('https://getcomposer.org/installer');" | php)`
      puts "Renaming composer.phar to composer"
      puts `mv #{root_dir}/bin/composer.phar #{root_dir}/bin/composer`
    end
  end

  desc 'Update composer to the latest version'
  task :update do
    if !composer_exists?
      puts "Composer is not installed yet. Run `rake composer:install`."
      next
    end
    puts "Updating composer..."
    puts `#{composer_path} self-update 2>&1`
  end

  desc 'Install globally required installer packages'
  task :global_packages do
      packages = {
          #@TODO dependencies conflicting with Laravel.
          laravel_installer: { version: "@stable", package: "laravel/installer" },
          lumen_installer: { version: "@stable", package: "laravel/lumen-installer" },
          psych: { version: "@stable", package: "psy/psysh" },
          phpcs: { version: "@stable", package: "squizlabs/php_codesniffer" },
          phpcs_fixer: { version: "@stable", package: "friendsofphp/php-cs-fixer" },
          valet: { version: "@stable", package: "laravel/valet" },
      }

      packages.each do |package_name, package|
        puts "", "Installing #{package_name.to_s.tr('_', ' ')}", ""
        puts `#{composer_path} global require #{package[:package]}=#{package[:version]}`
      end
  end

end

task :default => [:install, "composer:install", "composer:update"]
