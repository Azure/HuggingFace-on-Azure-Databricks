# Training and Inference of Hugging Face models on Azure Databricks

**This repository contains the code for the blog post series [Optimized Training and Inference of Hugging Face Models on Azure Databricks](https://techcommunity.microsoft.com/t5/ai-customer-engineering-team/optimized-training-and-inference-of-hugging-face-models-on-azure/ba-p/3631357).**

**If you want to reproduce the Databricks Notebooks, you should first follow the steps below to set up your environment:**

1. Create a Azure Databricks Workspace: you can create one by following [these instructions](https://docs.microsoft.com/en-us/azure/databricks/scenarios/quickstart-create-databricks-workspace-portal?tabs=azure-portal#create-an-azure-databricks-workspace) and you can select the *Standard* pricing tier.

2. Create a Cluster: you can follow [these instructions](https://docs.microsoft.com/en-us/azure/databricks/clusters/create) to create your cluster. Your cluster configuration should be based on nodes of the type *Standard_NC4as_T4_v3*. Please make sure you have enough *CPU cores* of that type, otherwise work with your Azure subscription administrator to request a quota increase. Use the information below when creating your cluster:
- *Databricks runtime version* should be at least *11.2 ML (GPU, Scala 2.12, Spark 3.3.0)*
- *worker type* should be *Standard_NC4as_T4_v3* and number of workers should be at least 2 (the notebooks here were run with 8 worker nodes)
- *Driver type* should be the same as worker type
- Disable *autoscaling*

3. Install Python libraries in your cluster: you can follow [these instructions](https://docs.microsoft.com/en-us/azure/databricks/libraries/cluster-libraries#cluster-installed-library) to install the libraries. Please install the following *PyPI* libraries in your cluster:
- *transformers==4.20.1*
- *sentencepiece*
- *datasets*
- *deepspeed*
- *mpi4py*
- *ninja*

4. Install a *cluster-scoped init script* in your cluster. This is needed for installing the *ninja* Linux library. The script to be installed is the [*ninja_install.sh*](). You can follow [these instructions](https://docs.microsoft.com/en-us/azure/databricks/clusters/init-scripts#cluster-scoped-init-scripts) to learn how to install it.

**The notebooks should be run in the following order:**

1. [*data_preparation.ipynb*](https://github.com/Azure/HuggingFace-on-Azure-Databricks/blob/main/data_preparation.ipynb): it downloads and prepares the datasets needed for model training and inference.
2. [*model_training_hvd.ipynb*](https://github.com/Azure/HuggingFace-on-Azure-Databricks/blob/main/model_training_hvd.ipynb): it performs distributed fine tuning using *PyTorch* and *Horovod* on the pre-trained *Hugging Face* model.
3. [*model_training_hvd_deepspeed.ipynb*](https://github.com/Azure/HuggingFace-on-Azure-Databricks/blob/main/model_training_hvd_deepspeed.ipynb): it performs distributed fine tuning using *PyTorch* and *Horovod*, optimized with *DeepSpeed*, on the pre-trained *Hugging Face* model.
4. [*model_inference_hvd.ipynb*](https://github.com/Azure/HuggingFace-on-Azure-Databricks/blob/main/model_inference_hvd.ipynb): it performs distributed inference using *PyTorch* and *Horovod* on the fine-tuned model.
5. [*model_inference_hvd_deepspeed.ipynb*](https://github.com/Azure/HuggingFace-on-Azure-Databricks/blob/main/model_inference_hvd_deepspeed.ipynb): it performs distributed inference using *PyTorch* and *Horovod*, optimized with *DeepSpeed*, on the fine-tuned model.
6. [*model_inference_pudf.ipynb*](https://github.com/Azure/HuggingFace-on-Azure-Databricks/blob/main/model_inference_pudf.ipynb): it performs distributed inference using *Transformer's Pipeline* and *Pandas UDF* on the fine-tuned model.
7. [*model_inference_pudf_deepspeed.ipynb*](https://github.com/Azure/HuggingFace-on-Azure-Databricks/blob/main/model_inference_pudf_deepspeed.ipynb) it performs distributed inference using *Transformer's Pipeline* and *Pandas UDF*, optimized with *DeepSpeed*, on the fine-tuned model.
