#!/usr/bin/env python3
'''
Sample django project with a setup script
'''
from setuptools import setup, find_packages

setup(
    name="setup_example",
    version="0.1.0",
    packages=find_packages("python"),
    package_dir={"": "python"},
)
