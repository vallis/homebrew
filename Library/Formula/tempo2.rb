require 'formula'

class Tempo2 < Formula
  homepage 'http://www.atnf.csiro.au/research/pulsar/tempo2'
  url 'http://downloads.sourceforge.net/project/tempo2/Tempo2%20Release%20Versions/tempo2-2013.9.1.tar.gz'
  sha1 'd869221850dfd6f887a11f127115427bef85f15f'

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'pkg-config' => :build

  # for the plugins
  depends_on 'cfitsio'
  depends_on 'fftw'
  depends_on 'gsl'
  depends_on 'pgplot'
  depends_on :x11

  def install
    ENV['TEMPO2'] = "#{share}/tempo2"

    system "./configure", "--prefix=#{prefix}"

    system "make"
    system "make", "install"

    system "make", "plugins"
    system "make", "plugins-install"

    (share/'tempo2').install 'T2runtime/atmosphere'
    (share/'tempo2').install 'T2runtime/clock'
    (share/'tempo2').install 'T2runtime/earth'
    (share/'tempo2').install 'T2runtime/ephemeris'
    (share/'tempo2').install 'T2runtime/observatory'
    (share/'tempo2').install 'T2runtime/plugin_data'
    (share/'tempo2').install 'T2runtime/solarWindModel'
  end

  test do
    # test fails because tempo2 incorrectly returns error code 1 when asked for version
    system "#{bin}/tempo2", "-v"
  end

  def caveats; <<-EOS.undent
    Before using tempo2, you need to set the TEMPO2 environment variable to:
      TEMPO2=#{HOMEBREW_PREFIX}/share/tempo2
    EOS
  end
end
