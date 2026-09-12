{ pkgs, ... }:

{
  home.packages = [
    pkgs.gh
  ];

  home.sessionVariables.DELTA_PAGER = "less -R";

  programs.git = {
    enable = true;

    ignores = [
      "*~"
      "*.swp"
      "*result*"
      ".env"
      ".direnv"
      ".worktree"
      "node_modules"
    ];

    settings = {
      pull.rebase = true;
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";

      alias = {
        a = "add --patch";
        ad = "add";
        b = "branch";
        ba = "branch -a";
        bd = "branch --delete";
        bdd = "branch -D";
        c = "commit";
        ca = "commit --amend --no-edit";
        cm = "commit --message";
        co = "checkout";
        cb = "checkout -b";
        pc = "checkout --patch";
        cl = "clone";
        d = "diff";
        ds = "diff --staged";
        h = "show";
        p = "push";
        pf = "push --force-with-lease";
        pl = "pull";
        r = "rebase";
        ra = "rebase --abort";
        rc = "rebase --continue";
        ri = "rebase --interactive";
        rs = "reset";
        rsh = "reset --hard";
        s = "status --short --branch";
        ss = "status";
        st = "stash";
        stc = "stash clear";
        sth = "stash show --patch";
        stl = "stash list";
        stp = "stash pop";
        forgor = "commit --amend --no-edit";
        oops = "checkout --";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options.dark = true;
  };
}