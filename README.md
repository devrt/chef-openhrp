OpenHRP Cookbook
================

This cookbook will install OpenHRP a dynamics simulator for robotics.

[![Build Status](http://ci.devrt.tk/job/chef-openhrp/badge/icon)](http://ci.devrt.tk/job/chef-openhrp/)

Requirements
------------

- `build-essential` - OpenHRP requires c++ compiler.
- `python` - OpenHRP requires python.
- `omniorb` - OpenHRP requires omniORB.
- `collada-d0m` - OpenHRP requires collada-dom.
- `openrtm-aist` - OpenHRP requires OpenRTM-aist.

Attributes
----------

No attributes yet.

Usage
-----

Just include `openhrp` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[openhrp]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------

Apache 2.0

Authors: Yosuke Matsusaka
