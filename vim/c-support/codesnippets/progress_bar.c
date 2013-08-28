#include <stdio.h>
#include <string.h>

/**
 * print a progress bar, like 'prompt 12%[======>              ]'
 * @param prompt    the prompt string
 * @param cur       current steps of progress
 * @param max       maximum steps of whole progress
 * @param bar_width the width of progress bar
 */
void
progress_print(const char* prompt,
               int cur,
               int max,
               int bar_width)
{
    int i;
    float ratio = cur / (float)max;

    if (ratio <= 0.0)
        ratio = 0.0;
    else if (ratio >= 1.0)
        ratio = 1.0;
    if (prompt == NULL)
        prompt = "";

    bar_width -= strlen(prompt);
    bar_width -= 7;

    cur = ratio * bar_width;

    fprintf(stdout, "%s [", prompt);

    for (i = 0; i < bar_width; i++)
    {
        if (i < cur)
            fputc('=', stdout);
        else if (i == cur)
            fputc('>', stdout);
        else
            fputc(' ', stdout);
    }

    fprintf(stdout, "]%3d%%\r", (int)(ratio * 100));

    fflush(stdout);
}

int
main(int argc, char** argv)
{
    int max = 1000;
    int step;

    step = 0;
    while (step <= max)
    {
        progress_print("the first bar", step, max, 80);
        step++;
        usleep(20000);
    }
    fprintf(stdout, "\n");

    step = 0;
    while (step <= max)
    {
        progress_print("the second bar", step, max, 80);
        step++;
        usleep(30000);
    }
    fprintf(stdout, "\n");

    return 0;
}
