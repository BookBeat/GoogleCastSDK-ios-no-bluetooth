# ========== generate_license.rb ==========
# Given the path to a `OpenSourceLicenses` directory from the download of
# a GoogleCastSDK framework release, this script outputs a combined `LICENSE`
# file in the same directory as the script.
#
# Inputs
# ------
# - Argument 1: An absolute path to a `OpenSourceLicenses` directory,
#   containing `oss_licenses_index.plist` and `oss_licenses.bin`.
#
# Outputs
# -------
# - A `LICENSE` file in the same directory as the script. The contents of the
#   file will be the combined licenses.
# =========================================

require 'cfpropertylist'

def parse_index(filepath)
    plist = CFPropertyList::List.new(:file => filepath)
    entries = CFPropertyList.native_types(plist.value)
    entries.map do |entry|
        {:name => entry["name"], :offset => entry["offset"], :size => entry["size"]}
    end
end

def get_license_text(bin_path, offset, size)
    File.open(bin_path, "rb") do |f|
        f.seek(offset)
        f.read(size)
    end
end

def main(licenses_directory)
    # Change the working directory to the directory containing the
    # script. This means that the script doesn't have to worry about
    # where it's invoked from.
    Dir.chdir(File.expand_path(File.dirname(__FILE__)))

    licenses = parse_index(File.join(licenses_directory, "oss_licenses_index.plist"))
    bin_path = File.join(licenses_directory, "oss_licenses.bin")
    combined_license = licenses.map do |license|
        <<~EOF
        #{license[:name]}
        #{get_license_text(bin_path, license[:offset], license[:size])}
        EOF
    end.join("\n\n")

    # Output the combined LICENSE file in the same directory as the script
    File.open("LICENSE", "w") do |f|
        f.write(combined_license)
    end
end

main(ARGV[0])