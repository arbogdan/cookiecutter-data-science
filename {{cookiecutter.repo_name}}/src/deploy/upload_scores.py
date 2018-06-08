import mmmm
import datetime
import sys
import os


def run_from_ipython():
    try:
        __IPYTHON__
        return True
    except NameError:
        return False


if run_from_ipython():
    # project_dir = os.getcwd()
    project_dir = os.path.join(os.getcwd(), os.pardir, os.pardir)
else:
    project_dir = os.path.join(os.path.dirname(__file__), os.pardir, os.pardir)
src_dir = os.path.join(project_dir, "src")
sys.path.append(src_dir)

from data.utils import vertica_python_conn_wrapper

db_conn = vertica_python_conn_wrapper(account="marketing")

# There are two ways to load scores of a model
# The 1st way,
mmmm.new_score(
    model_name='titanic',
    model_version='1.0',
    model_domain='SM',
    score_date=datetime.now(),
    scores=[0.87, 0.83, 0.83, 0.87],
    # should be carefully created and documented
    links=['ABC123', 'ABC124', 'ABC125', 'ABC123'],
    db_conn=db_conn)

# The 2nd way,
mmmm.new_score(
    model_id='SM-titanic-1.0',
    score_date=datetime.now(),
    scores=[0.87, 0.83, 0.83, 0.87],
    # should be carefully created and documented
    links=['ABC123', 'ABC124', 'ABC125', 'ABC123'],
    db_conn=db_conn)
