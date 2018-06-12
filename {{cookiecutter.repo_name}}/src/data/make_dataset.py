# -*- coding: utf-8 -*-
import os
import click
import logging
import sys
import pandas as pd


def run_from_ipython():
    try:
        __IPYTHON__
        return True
    except NameError:
        return False


if run_from_ipython():
    # optional settings...
    # from IPython import get_ipython
    # ipython = get_ipython()
    # ipython.magic("matplotlib inline")
    project_dir = os.getcwd()
else:
    project_dir = os.path.join(os.path.dirname(__file__), os.pardir, os.pardir)
src_dir = os.path.join(project_dir, "src")
sys.path.append(src_dir)


from data.utils import vertica_python_conn_wrapper


@click.command()
@click.argument('input_filepath', type=click.Path(exists=True))
@click.argument('output_filepath', type=click.Path())
def main(input_filepath, output_filepath):
    """ Runs data processing scripts to turn raw data from (../raw) into
        cleaned data ready to be analyzed (saved in ../processed).
    """
    logger = logging.getLogger(__name__)
    logger.info('making final data set from raw data')
    with open(input_filepath, "r") as f:
        query = f.read()

    conn = vertica_python_conn_wrapper()

    df = pd.read_sql_query(query, conn)
    df.to_pickle(output_filepath)


if __name__ == '__main__':
    log_fmt = '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    logging.basicConfig(level=logging.INFO, format=log_fmt)

    # not used in this stub but often useful for finding various files
    project_dir = os.path.join(os.path.dirname(__file__), os.pardir, os.pardir)

    main()
