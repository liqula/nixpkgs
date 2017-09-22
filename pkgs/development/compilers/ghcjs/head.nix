{ fetchgit, fetchFromGitHub, bootPkgs }:

bootPkgs.callPackage ./base.nix {
  version = "0.2.020170919";

  inherit bootPkgs;

  ghcjsSrc = fetchFromGitHub {
    # TODO: switch back to the regular ghcjs repo
    # when https://github.com/ghcjs/ghcjs/pull/573 is merged.
    owner = "k0001";
    repo = "ghcjs";
    rev = "eb8670c4b03b4a0ff5dd7ac3f524b410b37051ea";
    sha256 = "13s8wz9gk82cpwskc7ic3fvcpy572g87ny4icmj1apfzrrcpdp1v";
  };
  ghcjsBootSrc = fetchgit {
    # TODO: switch back to git://github.com/ghcjs/ghcjs-boot.git
    # when https://github.com/ghcjs/ghcjs-boot/pull/41 is merged.
    url = git://github.com/cocreature/ghcjs-boot.git;
    rev = "8020b2a9be585e958050c0a2c9144961bc8fad38";
    sha256 = "1n6xmcn6dwp1lsalyr84gqbx41qycisx5dxdxmw4wdh0v2pclqrq";
    fetchSubmodules = true;
  };

  shims = import ./head_shims.nix { inherit fetchFromGitHub; };
  stage1Packages = [
    "array"
    "base"
    "binary"
    "bytestring"
    "containers"
    "deepseq"
    "directory"
    "filepath"
    "ghc-boot"
    "ghc-boot-th"
    "ghc-prim"
    "ghci"
    "ghcjs-prim"
    "ghcjs-th"
    "integer-gmp"
    "pretty"
    "primitive"
    "process"
    "rts"
    "template-haskell"
    "time"
    "transformers"
    "unix"
  ];
  stage2 = import ./head_stage2.nix;
}
