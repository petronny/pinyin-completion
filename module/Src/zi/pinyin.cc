/*
 * pinyin.c - an pinyin module for zsh
 *
 * This file is part of zsh, the Z shell.
 *
 * Copyright (c) 1996-1997 Zoltán Hidvégi
 * All rights reserved.
 *
 * Permission is hereby granted, without written agreement and without
 * license or royalty fees, to use, copy, modify, and distribute this
 * software and to distribute modified versions of this software for any
 * purpose, provided that the above copyright notice and the following
 * two paragraphs appear in all copies of this software.
 *
 * In no event shall Zoltán Hidvégi or the Zsh Development Group be liable
 * to any party for direct, indirect, special, incidental, or consequential
 * damages arising out of the use of this software and its documentation,
 * even if Zoltán Hidvégi and the Zsh Development Group have been advised of
 * the possibility of such damage.
 *
 * Zoltán Hidvégi and the Zsh Development Group specifically disclaim any
 * warranties, including, but not limited to, the implied warranties of
 * merchantability and fitness for a particular purpose.  The software
 * provided hereunder is on an "as is" basis, and Zoltán Hidvégi and the
 * Zsh Development Group have no obligation to provide maintenance,
 * support, updates, enhancements, or modifications.
 *
 */

#include <getopt.h>
#include <stdio.h>

#include <cpp-pinyin/G2pglobal.h>
#include <cpp-pinyin/Pinyin.h>

__BEGIN_DECLS

#include "pinyin.mdh"
#include "pinyin.pro"

/* parameters */
static struct builtin bintab[] = {
    BUILTIN("zpinyin", 0, pinyin, 0, -1, 0, "", NULL),
};

/**/
static int pinyin(char *nam, char **args, Options ops, UNUSED(int func)) {
  char usage[] = "zpinyin setDictionaryPath [dictionary_path]\n"
                 "zpinyin hanziToPinyin [(-t|--man_tone_style) (0|1|2|8*)] "
                 "[(-e|--error) (default*|ignore)] [-c|--candidates] "
                 "[-v|--v_to_u]... hanzi [pinyin*]";
  if (args[0] == NULL) {
    puts(usage);
    return EXIT_SUCCESS;
  }
  if (ztrcmp(args[0], "setDictionaryPath") == 0) {
    char *dict = args[1];
    if (dict == NULL)
      dict = (char *)"/usr/lib/dict";
    Pinyin::setDictionaryPath(dict);
  } else if (ztrcmp(args[0], "hanziToPinyin") == 0) {
    const auto g2p_man = std::make_unique<Pinyin::Pinyin>();
    unsigned int argc = 0;
    while (args[++argc])
      ;
    int c;
    char shortopts[] = "t:e:cv";
    static struct option longopts[] = {
        {"man_tone_style", required_argument, NULL, 't'},
        {"error", required_argument, NULL, 'e'},
        {"candidates", no_argument, NULL, 'c'},
        {"v_to_u", no_argument, NULL, 'v'},
        {NULL, 0, NULL, 0}};
    Pinyin::ManTone::Style man_tone_style = Pinyin::ManTone::Style::TONE3;
    Pinyin::Error error = Pinyin::Error::Default;
    bool candidates = false;
    bool v_to_u = false;
    // args[0], ..., NULL == args[argc]
    optind = 0;
    while ((c = getopt_long(argc, args, shortopts, longopts, NULL)) != -1) {
      switch (c) {
      case 't':
        man_tone_style = Pinyin::ManTone::Style(optarg[0] - '0');
        break;
      case 'e':
        error = optarg[0] == 'i' ? Pinyin::Error::Ignore : Pinyin::Error::Default;
        break;
      case 'c':
        candidates = true;
        break;
      case 'v':
        v_to_u = true;
        break;
      default:
        goto end_parse;
      }
    }
  end_parse:
    if (args[optind]) {
      const char *hans = unmetafy(args[optind], NULL);
      setsparam(args[optind + 1] ? args[optind + 1] : (char *)"pinyin",
                ztrdup_metafy(g2p_man->hanziToPinyin(
                  hans, man_tone_style, error, candidates, v_to_u
                ).toStdStr().c_str()));
    } else {
      fputs(usage, stderr);
      return EXIT_FAILURE;
    }
  } else {
    fputs(usage, stderr);
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}

/*
 * boot_ is executed when the module is loaded.
 */

static struct conddef cotab[] = {};

static struct paramdef patab[] = {};

static struct mathfunc mftab[] = {};

static struct features module_features = {
    bintab, sizeof(bintab) / sizeof(*bintab),
    cotab,  sizeof(cotab) / sizeof(*cotab),
    mftab,  sizeof(mftab) / sizeof(*mftab),
    patab,  sizeof(patab) / sizeof(*patab),
    0};

/**/
int setup_(UNUSED(Module m)) { return EXIT_SUCCESS; }

/**/
int features_(Module m, char ***features) {
  *features = featuresarray(m, &module_features);
  return EXIT_SUCCESS;
}

/**/
int enables_(Module m, int **enables) {
  return handlefeatures(m, &module_features, enables);
}

/**/
int boot_(Module m) { return EXIT_SUCCESS; }

/**/
int cleanup_(Module m) { return setfeatureenables(m, &module_features, NULL); }

/**/
int finish_(UNUSED(Module m)) { return EXIT_SUCCESS; }

__END_DECLS
