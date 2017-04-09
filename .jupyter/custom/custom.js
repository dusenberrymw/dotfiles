// Configure Vim bindings with CodeMirror API
require([
  'nbextensions/vim_binding/vim_binding',
], function() {
  // Map `jj` to `Escape, l` in Insert mode, where the `l` prevents the
  // cursor from moving backwards.
  CodeMirror.Vim.map("jj", "<Esc>l", "insert");
  // Map `;` to `:` for convenience.
  CodeMirror.Vim.map(";", ":", "normal");
  // Map j/k to gj/gk for multi-line navigation.
  CodeMirror.Vim.map("j", "<Plug>(vim-binding-gj)", "normal");
  CodeMirror.Vim.map("k", "<Plug>(vim-binding-gk)", "normal");
});

