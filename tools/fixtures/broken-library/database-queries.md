# Database queries

- Prisma client only. No raw SQL outside migrations
- Select the columns you need. Never a bare findMany()
- Every foreign key gets an index in the same migration that creates it
- Transactions for anything that writes to more than one table
- No queries inside a loop. Batch or join
