#!/usr/bin/python3

import argparse


def process_line(line):
    fields = line.split(r"\t")
    print(f"{fields[0]}")


def read_file(file, resume, checkf):
    with open(file) as fp:
        for line in fp:
            process_line(line.strip())


def main():
    parser = argparse.ArgumentParser(description="scans the samples from sqlite file")
    parser.add_argument('text', type=str, help='text')
    parser.add_argument('--resume', type=int, help='line to resume from')
    args = parser.parse_args()
    read_file(args.text, args.resume, process_line)


if __name__ == '__main__':
    main()
