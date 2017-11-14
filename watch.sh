watchman-make --make 'alex grammar/Lexer.x -o src/Parser/Lexer.hs' \
    -p 'grammar/*.x' \
    -t '' \
    --make 'happy grammar/Parser.y -o src/Parser/Parser.hs --info=grammar/Parser.info' \
    -p 'grammar/*.y' \
    -t '' \
    --make 'hpack' \
    -p 'package.yaml' \
    -t '' #\
    # --make 'stack' \
    # -p 'src/*.hs' \
    # -t 'test' \
    # --make 'stack' \
    # -p 'test/*.hs' \
    # -t 'test' \
