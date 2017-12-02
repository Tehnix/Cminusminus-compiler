int avg(int count, int *value) {
    int i, total;
    total = 0;
    for (i = 0; i < count; i++) {
        total = total + value[i];
    }

    return (total / count);
}

int test(void) {
    int test_h, test_g;
    test_g = 5;
    return 10;
}

int test2(void) {
    int test2_h, test2_g;
    test2_g = 5;
    test2_h = 8;
    return test2_g + test2_h;
}

int test3(int f) {
    int test3_h, test3_g;
    test3_g = 90;
    test3_h = 9;
    return test3_g + test3_h + f;
}

int main(void) {
    int studentNumber, count, i, sum, g, h, ff, lower, greater;
    int mark[4];
    float average;
    char testChar, testString[4];

    ff = 1;
    g = 1;
    for (i = 0; i < 5; i++) {
        ff = ff + 2;
    }
    // while (g < 5) {
    //     ff = ff + 1;
    //     g++;
    // }
    mark[2] = 5;
    mark[3] = 8;
    h = 1 + 2.0;
    printf("Testing:\n");
    printf("  Int = %d\n", 5);
    printf("  Float = %f\n", 5.0);

    // mark[4] = 8;
    if (10 > 40) {
      h = 1;
    } else {
      h = 2;
    }
    if (10 < 40) {
        h = 4;
    }

    testChar = 'c';

    h++;
    h--;
    --h;
    ++h;

    // Testing bare function call (stmt fun).
    test2();

    *testString = "Hey";
    count = 4;
    sum = 0;
    lower = 4 < 5;
    greater = 5 > 4;

    h = test();
    g = test2();
    ff = test3(2 + 4 + 10);

    for (i = 0; i < count; i++) {
        mark[i] = i * 30;
        sum = sum + mark[i];
        average = avg(i + 1, mark);
        if (average > 40) {
            printf("%f\n", average);
        }
    }
}
