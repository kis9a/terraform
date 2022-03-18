# tfref

open terraform documentation easily.
[GitHub - kis9a/tfref: Open terraform reference easily.](https://github.com/kis9a/tfref)

### Installation

```bash
install_path=/usr/local/bin/tfref
sudo curl -s https://raw.githubusercontent.com/kis9a/tfref/main/tfref > "$install_path"
chmod +x "$install_path"
```

### Usage

```
USAGE:
  tfref [options] <resource|data>

OPTIONS:
  -h: help
  -t: test: bash tfref_test
  -f: open_read_file_line_up: tfref -f $file_path $line

SUPPORTED TYPE:
  aws, datadog, data_datadog, data_aws

EXAMPLE:
  tfref aws_instance
  tfref datadog_monitor
  tfref data.aws_instance
  tfref data.datadog_api_key
  tfref -f "./ec2.tf" 20
```

### vim

```bash
function! s:tfref()
  let fullpath=expand('%:p')
  let cursorline=line('.')
  let cmd = "!tfref -f \"" . fullpath . "\" " . cursorline
  silent execute cmd
endfunction

nnoremap <silent> <Leader>tf :call <SID>tfref()<CR>
```
