# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Frp < Formula
  desc "A platform for building proxies to bypass network restrictions."
  homepage "https://github.com/fatedier/frp"
  url "https://github.com/fatedier/frp/releases/download/v0.14.1/frp_0.14.1_darwin_amd64.tar.gz"
  version "0.14.1"
  sha256 "50f2341fb746144905009c56929673f0c6e33611fb69a5a287e9e2ddacf67952"
  #openssl dgst -sha256 frp_0.14.1_darwin_amd64.tar.gz 

  # depends_on "cmake" => :build

  def install

    bin.install "frpc"
    bin.install "frps"

    (etc/"frp").mkpath
    etc.install "frpc.ini" => "frp/frpc.ini"
    etc.install "frps.ini" => "frp/frps.ini"

  end

  plist_options :manual => "frpc -c #{HOMEBREW_PREFIX}/etc/frp/frpc.ini"

  def plist; <<~EOS
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>RunAtLoad</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/frpc</string>
        <string>-c</string>
        <string>#{etc}/frp/frpc.ini</string>
      </array>
    </dict>
  </plist>
  EOS
  end




  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test frp`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/frpc", "-version"
  end
end