from aiogram import Router
from aiogram.filters import Command
from aiogram.types import Message

about_router = Router(name="/about")


@about_router.message(Command("about"))
async def command_about_handler(message: Message) -> None:
    """
    This handler receives messages with `/about` command
    """
    await message.reply(
        allow_sending_without_reply= False,
        text= "Maintainer nathmahale, application source code - URL")