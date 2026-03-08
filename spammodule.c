#include <Python.h>
#include <stdlib.h>

static PyObject *SpamError;

static PyObject *
spam_system(PyObject *self, PyObject *args)
{
    const char *command;
    int sts;

    if (!PyArg_ParseTuple(args, "s", &command))
        return NULL;
    sts = system(command);
    return PyLong_FromLong(sts);
}

/// Module method table

static PyMethodDef SpamMethods[] = {
    {"spam_system",
     spam_system,
     METH_VARARGS,
     "Execute a system command and return its exit status.\n\n"},
    {NULL, NULL, 0, NULL} /* Sentinel - marks the end of the table */
};

static PyModuleDef spammodule = {
    PyModuleDef_HEAD_INIT,
    "spam",
    "An example Python C extension module.",
    -1,
    SpamMethods,
};

PyMODINIT_FUNC PyInit_spam()
{
    PyObject *module;

    module = PyModule_Create(&spammodule);
    if (module == NULL)
    {
        return NULL;
    }
    SpamError = PyErr_NewException("spam.Error", NULL, NULL);
    Py_INCREF(SpamError);
    PyModule_AddObject(module, "Error", SpamError);
    return module;
}