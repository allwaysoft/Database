SELECT owner, table_name, blocks, empty_blocks from DBA_TABLES where empty_blocks /(blocks + empty_blocks) < .1;