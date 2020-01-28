{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation({
  name = "python-web-apps-101";
  src = ./.;

  buildInputs = with pkgs; [ 
    (texlive.combine {
      inherit (texlive)
        scheme-small
        amsmath
        amsfonts
        stmaryrd
        algorithm2e
        mdframed
        listings
        ifoddpage
        relsize
        needspace
        xcharter
        ly1
        cyrillic
        geometry;
    })
  ];

  buildPhase = ''
    # See: https://tex.stackexchange.com/questions/496275/texlive-2019-lualatex-doesnt-compile-document
    # Without export, lualatex fails silently, with exit code '0'
    export TEXMFVAR=$(pwd)
    lualatex -interaction=nonstopmode assignment.tex
  '';

  installPhase = ''
    mkdir -p $out
    cp assignment.log $out
    cp assignment.pdf $out
  '';
})
