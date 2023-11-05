{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

  outputs = { self, nixpkgs, flake-utils, nix-vscode-extensions }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            nix-vscode-extensions.overlays.default
          ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [ pkgs.bashInteractive ];
          buildInputs = with pkgs; [
            (vscode-with-extensions.override {
              vscode = vscodium;
              vscodeExtensions = with pkgs.vscode-marketplace; [
                # markdown
                # yzhang.markdown-all-in-one
                # R
                tianyishi.rmarkdown
                reditorsupport.r
                rdebugger.r-debugger
                # mikhail-arkhipov.r
                # Copilot
                github.copilot-labs
                github.copilot
                github.remotehub
                github.copilot-chat
                # VIM
                vscodevim.vim
                # NIX
                bbenoist.nix
                jnoortheen.nix-ide
              ];
            })
            R
            rPackages.languageserver
            rPackages.reticulate
            rPackages.readr
            rPackages.kableExtra
            rPackages.dplyr
            rPackages.ggplot2
            rPackages.magrittr
            rPackages.car
            rPackages.statsr
            rPackages.broom
            rPackages.stargazer
            rPackages.tidyr
            rPackages.gridExtra
            rPackages.ggpubr
            rPackages.cowplot
            rPackages.knitr
            rPackages.ellipse
            rPackages.plotly
            texlive.combined.scheme-full
            # Python
            python311
            python311Packages.numpy
            python311Packages.matplotlib
            python311Packages.plotly
          ];
        };
      });
}
