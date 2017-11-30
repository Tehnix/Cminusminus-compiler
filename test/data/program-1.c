int avg(int count, int *value) {
    int i, total;
    total = 0;
    for (i = 0; i < count; i++) {
        total = total + value[i];
    }

    return (total / count);
}

int main(void) {
    int studentNumber, count, i, sum;
    int mark[4];
    float average;

    count = 4;
    sum = 0;

    for (i = 0; i < count; i++) {
        mark[i] = i * 30;
        sum = sum + mark[i];
        average = avg(i + 1, mark);
        if (average > 40) {
            printf("%f\n", average);
        }
    }
}
