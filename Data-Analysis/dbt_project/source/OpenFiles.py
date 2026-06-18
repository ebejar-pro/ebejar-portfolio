import duckdb
con = duckdb.connect("retail.duckdb")
print(con.execute("SHOW TABLES").fetchall())
