# ========== generate_license.rb ==========
# Given the path to a `OpenSourceLicenses` directory from the download of
# a GoogleCastSDK framework release, this script outputs a combined `LICENSE`
# file in the same directory as the script.
#
# Inputs
# ------
# - Argument 1: An absolute path to a `OpenSourceLicenses` directory,
#   containing a bunch of html files and an `oss_licenses_index.txt` file.
#
# Outputs
# -------
# - A `LICENSE` file in the same directory as the script. The contents of the
#   file will be the combined licenses from all the html files.
# =========================================

def parse_index(filepath)
    lines = File.readlines(filepath)
    lines.map do |line|
        components = line.split("/")
        {:name => components.last, :license_filename => components.first}
    end
end

def get_license_text(license_path)
    raw_text = File.read(license_path)
    plaintext = raw_text[/<pre>(.*)<\/pre>/m, 1]
    return plaintext
end

def main(licenses_directory)
    # Change the working directory to the directory containing the
    # script. This means that the script doesn't have to worry about
    # where it's invoked from.
    Dir.chdir(File.expand_path(File.dirname(__FILE__)))

    licenses = parse_index(File.join(licenses_directory, "oss_licenses_index.txt"))
    combined_license = licenses.map do |license|
        <<~EOF
        #{license[:name]}
        #{get_license_text(File.join(licenses_directory, license[:license_filename]))}
        EOF
    end.join("\n\n")

    # Output the combined LICENSE file in the same directory as the script
    File.open("LICENSE", "w") do |f|
        f.write(combined_license)
    end
end

main(ARGV[0])