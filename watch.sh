watchman-make --make 'alex -g -s 2 grammar/Lexer.x -o src/Parser/Lexer.hs --info=grammar/Lexer.info' \
    -p 'grammar/*.x' \
    -t '' \
    --make 'happy -g -a -c grammar/Parser.y -o src/Parser/Parser.hs --info=grammar/Parser.info --pretty=grammar/Parser.pretty' \
    -p 'grammar/*.y' \
    -t '' \
    --make 'hpack' \
    -p 'package.yaml' \
    -t ''

