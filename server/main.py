# -*- coding: utf-8 -*-
"""FastAPI example for locust tests

- Author: Jinwoo Park
- Email: www.jwpark.co.kr@gmail.com
"""
import random

from fastapi import FastAPI

app = FastAPI()


@app.get("/random-number")
async def random_number() -> int:
    num = random.randint(1, 100)
    print(f"produced {num}")
    return num
