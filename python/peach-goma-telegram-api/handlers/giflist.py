from aiogram import Router
from aiogram.filters import Command
from aiogram.types import Message
from aiogram.types.input_file import FSInputFile
from os import listdir
from os.path import isfile, join, pardir
import os
import logging

giflist_router = Router()


@giflist_router.message(Command("giflist"))
async def command_giflist_handler(message: Message) -> None:
    """
    This handler receives messages with `/giflist` command
    python/peach-goma-telegram-api/gifs
    """
    gifStorageDirectory = join(os.getcwd(), 'gifs')
    logging.info(f"{gifStorageDirectory=}")

    giffileList = [f for f in listdir(gifStorageDirectory) if isfile(join(gifStorageDirectory, f))]

    for giffilename in giffileList:
        gif_caption = "gif_caption"
        logging.info(f"{giffilename=}")
        await message.reply_animation(
            # animation= open(giffilename, "rb").read(),
            animation= FSInputFile(path= gifStorageDirectory,
                                   filename= giffilename),
            caption=gif_caption,
            width=20,
            height=20
        )
