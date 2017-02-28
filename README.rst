mesos
=====

See the full `Salt Formulas installation and usage instructions
<http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.


Available states
================

.. contents::
    :local:


``mesos``
----------

Downloads, builds, and installs and configures Mesos. This takes quite a while (it took 40 minutes on a machine with
i5-3470 CPU @ 3.20GHz and 16 GB of memory).


``mesos.service``
------------------

Installs the server configuration and enables and starts Mesos.


Deploying a cluster
===================

Choose some masters and agents for your Mesos cluster. Say you want to configure masters ``'my-mesos-master-1'``,
``'my-mesos-master-2'``, and so on. Say you also want to configure agents ``'my-mesos-agent-1'``,
``'my-mesos-agent-2'``, and so on.

You can provide a pillar which identifies the masters and agents of your cluster:

.. code:: yaml

  mesos:
    master_target: "my-mesos-master-*"
    master_targeting_method: 'glob'
    agent_target: "my-mesos-agent-*"
    agent_targeting_method: 'glob'


Now apply the ``mesos.service`` stat on these machines:

.. code:: yaml

  base:
    'my-mesos-(master|agent)-*':
      - match: pcre
      - mesos.service
