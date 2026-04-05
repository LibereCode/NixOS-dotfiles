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
        };
};
}
