from aiogram import Router
from aiogram.filters import Command
from aiogram.types import Message, FSInputFile
from os import listdir
from os.path import isfile, join
import os
import logging

giflist_router = Router()


@giflist_router.message(Command("giflist"))
async def command_giflist_handler(message: Message) -> None:
    """
    This handler receives messages with `/giflist` command
    """
    gifStorageDirectory = join(os.getcwd(), 'gifs')
    logging.info(f"{gifStorageDirectory=}")

    giffileList = [f for f in listdir(
        gifStorageDirectory) if isfile(join(gifStorageDirectory, f))]

    for giffilename in giffileList:
        gif_caption = giffilename.split(".")[0]
        logging.info(f"{giffilename=}")
        await message.animation(
            animation=FSInputFile(path='/'.join(
                (gifStorageDirectory, giffilename))
            ),
            caption=gif_caption,
            width=20,
            height=20
        )
        logging.info(f"{message.get_url=}")
