{ ... }:
{
programs.nvf = {
        enable = true;
        settings.vim = {
                viAlias = true;
                vimAlias = true;
                lsp = {
                        enable = true;
                };
                options = {
                cmdheight = 2;
                cursorlineopt = "both";
                mouse = "nvc";
                splitright = true;
                splitbelow = true;
                shiftwidth = 4;
                tabstop = 4;
                softtabstop = 4;
                wrap = false;
                };
    };
};
}
