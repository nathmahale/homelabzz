from aiogram import Router
from aiogram.filters import Command
from aiogram.types import Message

privacy_router = Router()


@privacy_router.message(Command("privacy"))
async def command_privacy_handler(message: Message) -> None:
    """
    This handler receives messages with `/privacy` command
    """
    await message.answer("The recipient's UserID will only be used to send GIFs and deleted after each send operation, you can check the related Python3 source code here - URL")