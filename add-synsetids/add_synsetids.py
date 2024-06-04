#!/usr/bin/python3

import argparse
import sqlite3

sql_definitions = "SELECT synsetid, definition FROM synsets"
sql_count_definitions = "SELECT COUNT(*) FROM synsets"


def alter(conn):
    cursor = conn.cursor()
    alter_statement = 'ALTER TABLE synsets ADD COLUMN oewnsynsetid VARCHAR(10);'
    cursor.execute(alter_statement)
    conn.commit()


def column_exists(conn):
    cursor = conn.cursor()
    cursor.execute(f"PRAGMA table_info(synsets)")
    columns_info = cursor.fetchall()
    exists = any(column_info[1] == 'oewnsynsetid' for column_info in columns_info)
    cursor.close()
    return exists


def update(synsetid, nid, conn):
    cursor = conn.cursor()
    update_sql = f"UPDATE synsets SET oewnsynsetid = '{synsetid}' WHERE synsetid = {nid};"
    cursor.execute(update_sql)
    cursor.close()


def read_line(line, conn):
    fields = line.split(' ')
    update(fields[0], fields[1], conn)


def read_file(file, conn):
    with open(file) as fp:
        for line in fp:
            read_line(line.strip(), conn)


def run(database, file):
    conn = sqlite3.connect(database)
    if not column_exists(conn):
        alter(conn)
    read_file(file, conn)
    conn.commit()
    conn.close()


def main():
    parser = argparse.ArgumentParser(description="update sqlite database with external data")
    parser.add_argument('database', type=str, help='database')
    parser.add_argument('file', type=str, help='data to add in csv tab-format')
    args = parser.parse_args()
    run(args.database, args.file)


if __name__ == '__main__':
    main()
