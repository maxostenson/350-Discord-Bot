import discord
from discord.ext import commands
import asyncio
import asyncpg
import json
import time

from config_token import TOKEN

f = open(f"./cred.json", "r")
db_credentials = json.loads(f.read())

DEFAULT_PREFIX = '!'


async def run():
    description = "A Discord database bot"

    db = await asyncpg.create_pool(**db_credentials)
    print("Database Connection successful")

    bot = Bot(description=description, db=db)

    @bot.command()
    async def users(ctx):
        query = 'SELECT * FROM "User";' #" WHERE 'user.userid' = $1;"

        rows = await bot.db.fetch(query) #, ctx.author.id)
        for row in rows:
            await ctx.send(f"```userid: {row[0]}, Discord ID: {row[1]}, Discord Name: {row[2]}, Current XP: {row[3]}```")

    @bot.command()
    async def feedback(ctx):
        query = 'SELECT * FROM "Feedback";'

        rows = await bot.db.fetch(query)
        for row in rows:
            await ctx.send(f"```{row}```")

    @bot.command()
    async def bugreports(ctx):
        query = 'SELECT * FROM "BugReport";'

        rows = await bot.db.fetch(query)
        for row in rows:
            await ctx.send(f"```{row}```")

    @bot.command()
    async def rewards(ctx):
        query = 'SELECT * FROM "Rewards";'

        rows = await bot.db.fetch(query)
        for row in rows:
            await ctx.send(f"```{row}```")



    @bot.command()
    async def update(ctx, *, new_data: str):
        connection = await bot.db.acquire()
        async with connection.transaction():
            query = "UPDATE users SET data = $1 WHERE id = $2"
            await bot.db.execute(query, new_data, ctx.author.id)
        await bot.db.release(connection)

        await ctx.send(f"NEW:\n{ctx.author.id}: {new_data}")

    @bot.command(alasis='p')
    async def points(ctx):
        query = 'SELECT * FROM "User" WHERE user.discordid = $1;'
        row = await bot.db.fetch(query, ctx.author.id)
        if row is not None:
            await ctx.send(f"You have {row[6]:,d} points.")
        else:
            query = 'INSERT INTO "Users" VALUES ($1, $2, $3, $4, $5, $6)'
            result = await bot.db.fetch(query, ctx.author.id, ctx.author.name, 0, time.time(), 0, 1)



    try:
        await bot.start(TOKEN)
    except KeyboardInterrupt:
        await db.close()
        await bot.logout()


class Bot(commands.Bot):
    def __init__(self, **kwargs):
        super().__init__(
            description=kwargs.pop("description"),
            command_prefix=DEFAULT_PREFIX
        )

        self.db = kwargs.pop("db")

    async def on_ready(self):
        print("Bot Ready")
        print(f"Username: {self.user}\nID: {self.user.id}")




loop = asyncio.get_event_loop()
loop.run_until_complete(run())
