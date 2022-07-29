class Overmind < Formula
  desc "Process manager for Procfile-based applications and tmux"
  homepage "https://github.com/DarthSim/overmind"
  url "https://github.com/DarthSim/overmind/archive/v2.3.0.tar.gz"
  sha256 "a9fe0efc94b72ca11003940145ca4d48a8af32e5e9593d1a53757dd2eccacbb2"
  license "MIT"
  head "https://github.com/DarthSim/overmind.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1d59fd1eadd4029ec88ef668d7eeaf790c3db3137a9e5dafa7948ccd684c4dc2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "00af66eeee076ae3bccba58a690dc73f908b6af7ea0bfebf1fc6b81c5a88c445"
    sha256 cellar: :any_skip_relocation, monterey:       "9fbe36f34b548c9945aa64d3ff72bfd7e1398be8f06dc12392e25de3ac0e0988"
    sha256 cellar: :any_skip_relocation, big_sur:        "f0a2458bfe0cbe0a38ca8579b774e45262f68bf8a9f9d1d2ff70a9c388c21446"
    sha256 cellar: :any_skip_relocation, catalina:       "0d2b7a68b08aa6ce0a5cdfad5a90166248ee11fce70970d1e820918de612168a"
    sha256 cellar: :any_skip_relocation, mojave:         "07036145d0ff5102e0a64607cb1d253a49e66aa6ceb5ea4b82780a4078910c04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4c63f041aaf3949b972351ea2102a5405dc71d6c5e0de79cceb170745cf39d0a"
  end

  # Bump to 1.18 on the next release, if possible.
  depends_on "go@1.17" => :build
  depends_on "tmux"

  def install
    system "go", "build", "-ldflags", "-s -w", "-trimpath", "-o", bin/"overmind"
    prefix.install_metafiles
  end

  test do
    expected_message = "overmind: open ./Procfile: no such file or directory"
    assert_match expected_message, shell_output("#{bin}/overmind start 2>&1", 1)
    (testpath/"Procfile").write("test: echo 'test message'; sleep 1")
    expected_message = "test message"
    assert_match expected_message, shell_output("#{bin}/overmind start")
  end
end
