
mkdir lua

let filesToCompile = (ls ./fnl/quickterm | where ($it.name !~ "macro" ) | select name)

def compile-fennel-file [fnlFile] {
    let out = ($fnlFile | str replace -a "fnl" "lua")
    fennel --add-macro-path fnl/macros.fnl -c $fnlFile | save $out
    $"compiled to ($out)"
}

$filesToCompile | each {|it| compile-fennel-file $it.name}
