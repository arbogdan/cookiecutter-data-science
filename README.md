# MassMutual Data Science Project Structure Guidelines

_A logical, reasonably standardized, but flexible project structure for doing and sharing data science work._

A video showing how to start a project using these docs is [on Vimeo here](https://vimeo.com/225258953).

The slides from a presentation of this project (including the video) are in the `docs/` folder here.

#### Based on a project from Driven Data: [Project homepage](http://drivendata.github.io/cookiecutter-data-science/)


### Requirements to use this project structure template:
-----------
 - Python 2.7 or 3.5
 - [Cookiecutter Python package](http://cookiecutter.readthedocs.org/en/latest/installation.html) >= 1.4.0: This can be installed with pip:

``` bash
$ pip install cookiecutter
```

### To start a new project, run:
------------

    cookiecutter https://github.com/massmutual/cookiecutter-data-science

### The resulting directory structure
------------

The directory structure of your new project looks like this:

```
├── Makefile                   <- Makefile with commands like `make data` or `make train`
├── README.md                  <- The top-level README for developers using this project.
├── requirements.txt           <- The requirements file for reproducing the analysis environment, e.g.
│                                 generated with `pip freeze > requirements.txt`
|
├── data
│   ├── external               <- Data from third party sources.
│   ├── interim                <- Intermediate data that has been transformed.
│   ├── predictions
│   ├── processed              <- The final, canonical data sets for modeling.
│   └── raw                    <- The original, immutable data dump.
|
├── models                     <- Trained and serialized models, model predictions, or model summaries
|
├── references                 <- Data dictionaries, manuals, and all other explanatory materials.
|
├── reports                    <- Generated analysis as HTML, PDF, LaTeX, etc.
│   ├── figures                <- Generated graphics and figures to be used in reporting
│   └── tables
|
|
├── src                        <- Source code for use in this project.
│   ├── data
│   │   ├── R
│   │   │   └── utils.R
│   │   ├── __init__.py
│   │   ├── make_dataset.R
│   │   └── make_dataset.py
│   ├── evaluation
│   ├── exploratory
│   │   ├── R
│   │   └── __init__.py
│   ├── features                <- Scripts to turn raw data into features for modeling
│   │   ├── R
│   │   ├── __init__.py
│   │   ├── build_features.R
│   │   └── build_features.py
│   ├── models                   <- Scripts to train models and then use trained models to make predictions
│   │   ├── R
│   │   ├── __init__.py
│   │   ├── predict_model.py
│   │   ├── test_model.R
│   │   ├── test_model.py
│   │   ├── train_model.R
│   │   └── train_model.py
│   └── vis
│       ├── R
│       ├── __init__.py
│       ├── visualize.R
│       └── visualize.py
|
├── test_environment.py
└── tox.ini
```

<hr>

## FAQ

Q: Where should I put my Shiny App?

A:

1. Ideally each shiny app would live in it's own folder inside the vis folder.
2. There should be a data folder in there as well as ui.R, server.R, and global.R.
3. The data should live in the same folder as the app shiny treats it's enclosing folder as it's working directory.

Q: How do I deploy my Shiny App?  
  
A: Please visit [here](https://massmutual.atlassian.net/wiki/spaces/AAP/pages/427072326/Shiny+app+deployment+with+Docker) for details.  

Q: What are the default credentials for the example Shiny App?  
  
A: The default credentials are:  
    Username: test  
    Password: test  
  
Q: How do I sync my project files with S3?
  
A:  
  
1. Update the script `setup_s3.sh` to match your environment and make sure your project folder is setup as a git repository.
2. Run `source setup_s3.sh`. This adds the S3 credentials to your environment. Prior to running this command, you will need to install our AWS credentials tool using this command: `pip install git+ssh://git@github.com/massmutual/set-aws-credentials`.
3. Run `make sync_data_from_s3` to pull any existing data from S3. To push changes up to S3, run `make sync_data_to_s3`. 
4. You can perform a push and pull by running `make sync_s3`. 
5. Because the sync command's change management is not great, it's recommended that you confer with your teammates before pulling or pushing changes or give files unique or timestamped names.
<hr>
