Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6463020F5
	for <lists+linux-api@lfdr.de>; Mon, 25 Jan 2021 05:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbhAYEHi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 Jan 2021 23:07:38 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:33777 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbhAYEHe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 Jan 2021 23:07:34 -0500
Received: from [192.168.101.10] ([91.1.218.73]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MLyzP-1lLgyE3im9-00HyJy; Mon, 25 Jan 2021 05:03:52 +0100
Subject: Re: [PATCH v3 (resend)] tee: Add -q, --quiet, --silent option to not
 write to stdout
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Otto Moerbeek <otto@drijf.net>, Coreutils <coreutils@gnu.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Fabrice BAUZAC <noon@mykolab.com>, juli@clockworksquid.com,
        Jeffrey Walton <noloader@gmail.com>,
        freebsd-hackers@freebsd.org,
        William Ahern <william@25thandclement.com>,
        Roman Czyborra <roman@czyborra.com>, oshogbo@freebsd.org,
        tech@openbsd.org, Christian Groessler <chris@groessler.org>,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>, ed@nuxi.nl,
        Eric Pruitt <eric.pruitt@gmail.com>
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
 <20210124121845.38293-1-alx.manpages@gmail.com>
 <YA2ztHUATu1gOxoV@clue.drijf.net>
 <CAMMLpeSLbWtRrrzOjB6DJgZCem8KWpy7_pWmr6ecuGrSmg4Eng@mail.gmail.com>
From:   Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <d0f93c40-c471-7ef7-fa9a-2f467d775d3e@bernhard-voelker.de>
Date:   Mon, 25 Jan 2021 05:03:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAMMLpeSLbWtRrrzOjB6DJgZCem8KWpy7_pWmr6ecuGrSmg4Eng@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------74CEB4541933A37E03B2ADF5"
Content-Language: en-US
X-Provags-ID: V03:K1:P2S9pVtutlLQ03qT1MPiR6EDFeTNKQRyohtlGPETSIAMv57JQGZ
 2QGkYpON2mkWjqMEN5QVC733wdyuuffPHU+GKsifLXn/E/NQG4PCcv5WDjXPkkAtmPvhhd/
 L0kLqDn3FSk/KKkvehVQ2ji/wjsrKljjgKECFlKNYBGApb7w5jkvP7irwSR1bw0zY6K86eM
 xf8X6rAkSmIaJMy0KgQBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0lam23VJN2o=:VopTXESue8fsvN1GXUGFuw
 y3ZGdxwZ2fWud6Cl6G9WqIk8dPSTbdqNrB8EROAV5zI0rFIRkrVLzoLG92l0seISxduOv2KfI
 xUkV+6WlFvIDlADfH6QzKEb41xEPJ9kxU1id/G50TTzs8BKclQEx4x/NUox3F8wreOdFxoaiY
 UW23rCG4jUxjoZQqtBvYMNOU/vPmWTYjCiakBUaueOhajFgNGrZrQ5+Z96oZ7/2wf0l20Pu9h
 XTHiL3sMbDr8gfEF0P991DV/rTpjBSelSP4+3h8PlQYILNZkR7t6jZpVWvNtQOvFIh6t7ZRAT
 T3O170S7kv8/KyuIz7yxm1tExP/Iw7adNz9GCqJxsSGzTH4geu0AIQ563k5SfJpooUZU0gh5V
 kZlhe4gLyN0hW6ro16vRS0cvzKpi0G2va0e75QQKcP0aDUPLu7+leczEExzYORfPSJ1W9Ulqc
 4wzPhFnpag==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is a multi-part message in MIME format.
--------------74CEB4541933A37E03B2ADF5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 1/24/21 9:01 PM, Alex Henrie wrote:
> I am definitely interested. Bernhard Voelker seemed to express
> interest as well, conditional on -q being added to POSIX first.[1]

Just to clarify: I'm not as enthusiastic to add that option as it
may have sounded.

Let me put it like this: if -q once gets standardized by POSIX,
then we'd take it over in the GNU tee implementation.

Let me summarize so far:
The suggestion is to solve the problem to save some data coming from
a pipe as a different user.
There are at least those known solutions:
  - use > or >> redirection.
  - use dd(1)

I have the impression that a home for this feature was searched
in any tool, and as tee(1) already knew how to write to a file,
had the "append" feature, and is often used in pipes, it was
tempting to add it there.

But looking deeper, --quiet doesn't seem to fit well into 'tee'.
It even contradicts to the title line in the man page:
  "read from standard input and write to standard output and files"

An off-tech argument: ask a local plumber if he'd would ever use
a tee piece instead of a pipe end piece.  I guess he would only
if he wouldn't have anything else at hand.

A word to the proposed patch: what should happen, if the user does
not give a file?
  A | B | tee -q
The patch just silently ignored that situation which feels wrong.

Therefore, adding a feature which does not really fit is wrong, and
contradicts the one-tool-for-one-purpose UNIX philosophy.

OTOH I understand that there's a little gap in the tool landscape.
Astonishingly, there doesn't seem to exist a trivial tool to redirect
from standard input (or any other input file descriptor) to a file.
I wrote such a little tool in the attached:

  $ src/sink --help
  Usage: src/sink [OPTION]... FILE
  Copy input stream to FILE.

  Mandatory arguments to long options are mandatory for short options too.

    -a, --append              append to the given FILE, do not overwrite
    -c, --create              ensure to create FILE, error if exists
    -i, --input-stream=FD     read from stream FD instead of standard input

  The default input stream number FD is 0, representing the standard input.

This allows not only to copy data from standard input, but from any
file descriptor open for reading.  It also allows control over
how the output file will be opened (e.g. with O_CREAT|E_EXCL).

The OPs case would look like:

  echo 'foo' | sudo sink /etc/foo
or
  echo 'foo' | sudo sink -a /etc/foo  # append.
or
  echo 'foo' | sudo sink -c /etc/foo  # ensure creation of the file.

I'm not sure if this will ever be considered for inclusion -
I just did it "for fun". ;-)

Have a nice day,
Berny

--------------74CEB4541933A37E03B2ADF5
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-sink-add-new-program.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-sink-add-new-program.patch"

From 68473fb37ccfd65473ac186db4bd3bcc29560a40 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Mon, 25 Jan 2021 04:05:44 +0100
Subject: [PATCH] sink: add new program

* man/sink.x: Add file.
* src/sink.c: Likewise.
* AUTHORS (sink): Add entry.
* NEWS (New programs): Likewise.
* man/.gitignore (sink.1): Likewise.
* man/local.mk (man/sink.1): Likewise.
* po/POTFILES.in (src/sink.c): Likewise.
* src/.gitignore (sink): Likewise.
* README: Add the new tool to the list of programs.
* build-aux/gen-lists-of-programs.sh (normal_progs): Likewise.
* scripts/git-hooks/commit-msg (valid): Likewise.
* doc/coreutils.texi (sink invocation): Document the tool.
* tests/misc/sink.sh: Add a test.
* tests/local.mk (all_tests): Reference it.
* tests/misc/help-version.sh (sink_setup): Add test setup snippet.
---
 AUTHORS                            |   1 +
 NEWS                               |   4 +
 README                             |   6 +-
 build-aux/gen-lists-of-programs.sh |   1 +
 doc/coreutils.texi                 |  87 +++++++++++-
 man/.gitignore                     |   1 +
 man/local.mk                       |   1 +
 man/sink.x                         |   6 +
 po/POTFILES.in                     |   1 +
 scripts/git-hooks/commit-msg       |   2 +-
 src/.gitignore                     |   1 +
 src/sink.c                         | 205 +++++++++++++++++++++++++++++
 tests/local.mk                     |   1 +
 tests/misc/help-version.sh         |   1 +
 tests/misc/sink.sh                 | 146 ++++++++++++++++++++
 15 files changed, 456 insertions(+), 8 deletions(-)
 create mode 100644 man/sink.x
 create mode 100644 src/sink.c
 create mode 100755 tests/misc/sink.sh

diff --git a/AUTHORS b/AUTHORS
index 46948d5fd..5790616b4 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -79,6 +79,7 @@ sha384sum: Ulrich Drepper, Scott Miller, David Madore
 sha512sum: Ulrich Drepper, Scott Miller, David Madore
 shred: Colin Plumb
 shuf: Paul Eggert
+sink: Bernhard Voelker
 sleep: Jim Meyering, Paul Eggert
 sort: Mike Haertel, Paul Eggert
 split: Torbjorn Granlund, Richard M. Stallman
diff --git a/NEWS b/NEWS
index a6ba96450..3323b3300 100644
--- a/NEWS
+++ b/NEWS
@@ -2,6 +2,10 @@ GNU coreutils NEWS                                    -*- outline -*-
 
 * Noteworthy changes in release ?.? (????-??-??) [?]
 
+** New programs
+
+  sink: copy data from an input stream to a file.
+
 ** Bug fixes
 
   cp -a --attributes-only now never removes destination files,
diff --git a/README b/README
index 6cb7c2226..da98eb86f 100644
--- a/README
+++ b/README
@@ -13,9 +13,9 @@ The programs that can be built with this package are:
   id install join kill link ln logname ls md5sum mkdir mkfifo mknod mktemp
   mv nice nl nohup nproc numfmt od paste pathchk pinky pr printenv printf ptx
   pwd readlink realpath rm rmdir runcon seq sha1sum sha224sum sha256sum
-  sha384sum sha512sum shred shuf sleep sort split stat stdbuf stty sum sync
-  tac tail tee test timeout touch tr true truncate tsort tty uname unexpand
-  uniq unlink uptime users vdir wc who whoami yes
+  sha384sum sha512sum shred shuf sink sleep sort split stat stdbuf stty sum
+  sync tac tail tee test timeout touch tr true truncate tsort tty uname
+  unexpand uniq unlink uptime users vdir wc who whoami yes
 
 See the file NEWS for a list of major changes in the current release.
 
diff --git a/build-aux/gen-lists-of-programs.sh b/build-aux/gen-lists-of-programs.sh
index 3ec9a6dd1..e9921e912 100755
--- a/build-aux/gen-lists-of-programs.sh
+++ b/build-aux/gen-lists-of-programs.sh
@@ -112,6 +112,7 @@ normal_progs='
     sha512sum
     shred
     shuf
+    sink
     sleep
     sort
     split
diff --git a/doc/coreutils.texi b/doc/coreutils.texi
index 94c9fbfa5..743276bac 100644
--- a/doc/coreutils.texi
+++ b/doc/coreutils.texi
@@ -109,6 +109,7 @@
 * sha2: (coreutils)sha2 utilities.              Print or check SHA-2 digests.
 * shred: (coreutils)shred invocation.           Remove files more securely.
 * shuf: (coreutils)shuf invocation.             Shuffling text files.
+* sink: (coreutils)sink invocation.             Redirect a stream to a file.
 * sleep: (coreutils)sleep invocation.           Delay for a specified time.
 * sort: (coreutils)sort invocation.             Sort text files.
 * split: (coreutils)split invocation.           Split into pieces.
@@ -199,7 +200,7 @@ Free Documentation License''.
 * Disk usage::                   df du stat sync truncate
 * Printing text::                echo printf yes
 * Conditions::                   false true test expr
-* Redirection::                  tee
+* Redirection::                  sink tee
 * File name manipulation::       dirname basename pathchk mktemp realpath
 * Working context::              pwd stty printenv tty
 * User information::             id logname whoami groups users who
@@ -384,6 +385,7 @@ Conditions
 
 Redirection
 
+* sink invocation::              Redirect a stream to a file
 * tee invocation::               Redirect output to multiple files or processes
 
 File name manipulation
@@ -13744,14 +13746,91 @@ expr index + index a
 @cindex commands for redirection
 
 Unix shells commonly provide several forms of @dfn{redirection}---ways
-to change the input source or output destination of a command.  But one
-useful redirection is performed by a separate command, not by the shell;
-it's described here.
+to change the input source or output destination of a command.  But two
+useful redirections are performed by the separate commands, not by the shell;
+they're described here.
 
 @menu
+* sink invocation::             Redirect a stream to a file.
 * tee invocation::              Redirect output to multiple files or processes.
 @end menu
 
+@node sink invocation
+@section @command{sink}: Redirect a stream to a file
+
+@pindex sink
+@cindex pipe fitting
+@cindex source, file descriptor input
+@cindex read from a stream and write to a file
+
+The @command{sink} command copies the data of an input stream to a file given
+as argument.  The input stream defaults to the standard input, and can be
+changed to any other file descriptor open for reading.
+Synopsis:
+
+@example
+sink [@var{option}]@dots{} @var{file}
+@end example
+
+The program accepts the following options.  Also see @ref{Common options}.
+
+@table @samp
+@item -a
+@itemx --append
+@opindex -a
+@opindex --append
+Append the input data to the given file rather than overwriting it.
+
+@item -c
+@itemx --create
+@opindex -c
+@opindex --create
+Ensure that the program creates the given output file;
+fail if it already exists.
+
+@item -i @var{fd}
+@itemx --input-stream=@var{fd}
+@opindex -i
+@opindex --input-stream
+Read the input data from the stream associated to the numeric
+file descriptor @var{fd}.
+Without this option, the input file descriptor defaults to standard input.
+@end table
+
+The @command{sink} command may be useful to write the data at the end of a pipe
+to a file without using a shell redirection operator.
+@example
+cat file1 \
+  | grep pattern \
+  | tee file2 file3 \
+  | tr '[a-z]' '[A-Z]' \
+  | sink file4
+@end example
+
+Another example is to use it at the end of a pipe to write something via
+@command{sudo} into a file owned by the superuser.
+
+@example
+echo '127.0.0.2 localalias' | sudo sink -a /etc/hosts
+@end example
+
+Here is a more complex example to redirect the input from file descriptor
+@samp{6} which is associated to a pipe (instead of the default, standard input).
+
+@example
+$ mkfifo pipe \
+    && src/sink -i6 -c file 6<pipe &
+$ ( exec 1>pipe; \
+    for n in 1 2 3; do \
+      echo step$n; \
+      sleep 1; \
+    done >pipe; \
+    rm -f pipe )
+$ cat file
+step1
+step2
+step3
+@end example
 
 @node tee invocation
 @section @command{tee}: Redirect output to multiple files or processes
diff --git a/man/.gitignore b/man/.gitignore
index 4eecb7833..d4551d74f 100644
--- a/man/.gitignore
+++ b/man/.gitignore
@@ -74,6 +74,7 @@ sha384sum.1
 sha512sum.1
 shred.1
 shuf.1
+sink.1
 sleep.1
 sort.1
 split.1
diff --git a/man/local.mk b/man/local.mk
index d23699bae..3f407f4ee 100644
--- a/man/local.mk
+++ b/man/local.mk
@@ -141,6 +141,7 @@ man/sha384sum.1: src/sha384sum$(EXEEXT)
 man/sha512sum.1: src/sha512sum$(EXEEXT)
 man/shred.1:     src/shred$(EXEEXT)
 man/shuf.1:      src/shuf$(EXEEXT)
+man/sink.1:      src/sink$(EXEEXT)
 man/sleep.1:     src/sleep$(EXEEXT)
 man/sort.1:      src/sort$(EXEEXT)
 man/split.1:     src/split$(EXEEXT)
diff --git a/man/sink.x b/man/sink.x
new file mode 100644
index 000000000..a4a0b5725
--- /dev/null
+++ b/man/sink.x
@@ -0,0 +1,6 @@
+[NAME]
+sink \- copy data from an input stream to a file
+[DESCRIPTION]
+.\" Add any additional description here
+[SEE ALSO]
+cat(1), tee(1)
diff --git a/po/POTFILES.in b/po/POTFILES.in
index 5f9c8fc50..7cf439069 100644
--- a/po/POTFILES.in
+++ b/po/POTFILES.in
@@ -113,6 +113,7 @@ src/seq.c
 src/set-fields.c
 src/shred.c
 src/shuf.c
+src/sink.c
 src/sleep.c
 src/sort.c
 src/split.c
diff --git a/scripts/git-hooks/commit-msg b/scripts/git-hooks/commit-msg
index 8a4b894ef..8ade59b8e 100755
--- a/scripts/git-hooks/commit-msg
+++ b/scripts/git-hooks/commit-msg
@@ -20,7 +20,7 @@ my @valid = qw(
     install join kill link ln logname ls md5sum mkdir mkfifo mknod mktemp
     mv nice nl nohup nproc numfmt od paste pathchk pinky pr printenv printf
     ptx pwd readlink realpath rm rmdir runcon seq sha1sum sha224sum sha256sum
-    sha384sum sha512sum shred shuf sleep sort split stat stdbuf stty
+    sha384sum sha512sum shred shuf sink sleep sort split stat stdbuf stty
     sum sync tac tail tee test timeout touch tr true truncate tsort
     tty uname unexpand uniq unlink uptime users vdir wc who whoami yes
 
diff --git a/src/.gitignore b/src/.gitignore
index 86d82ad4b..eedb4d856 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -86,6 +86,7 @@ sha384sum
 sha512sum
 shred
 shuf
+sink
 sleep
 sort
 split
diff --git a/src/sink.c b/src/sink.c
new file mode 100644
index 000000000..c7571fdf4
--- /dev/null
+++ b/src/sink.c
@@ -0,0 +1,205 @@
+/* sink - read from standard input and write a file.
+   Copyright (C) 2021 Free Software Foundation, Inc.
+
+   This program is free software: you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation, either version 3 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */
+
+/* Bernhard Voelker */
+
+#include <config.h>
+#include <sys/types.h>
+#include <getopt.h>
+
+#include "system.h"
+#include "die.h"
+#include "error.h"
+#include "fadvise.h"
+#include "xbinary-io.h"
+#include "xdectoint.h"
+
+/* The official name of this program (e.g., no 'g' prefix).  */
+#define PROGRAM_NAME "sink"
+
+#define AUTHORS \
+  proper_name ("Bernhard Voelker")
+
+/* Upper bound on getdtablesize().  See gnulib/lib/fcntl.c.  */
+#define OPEN_MAX_MAX 0x10000
+
+/* If true, append to output file rather than truncating it. */
+static bool flag_append;
+
+/* If true, ensure to create the output FILE: mode O_CREAT | O_EXCL.  */
+static bool flag_creat;
+
+/* Input file descriptor, default to stdin.  */
+static int input_stream = STDIN_FILENO;
+
+static struct option const long_options[] =
+{
+  {"append", no_argument, NULL, 'a'},
+  {"create", no_argument, NULL, 'c'},
+  {"input-stream", required_argument, NULL, 'i'},
+  {GETOPT_HELP_OPTION_DECL},
+  {GETOPT_VERSION_OPTION_DECL},
+  {NULL, 0, NULL, 0}
+};
+
+void
+usage (int status)
+{
+  if (status != EXIT_SUCCESS)
+    emit_try_help ();
+  else
+    {
+      printf (_("Usage: %s [OPTION]... FILE\n"), program_name);
+      fputs (_("\
+Copy input stream to FILE.\n\
+"), stdout);
+
+      emit_mandatory_arg_note ();
+
+      fputs (_("\n\
+  -a, --append              append to the given FILE, do not overwrite\n\
+"), stdout);
+      fputs (_("\
+  -c, --create              ensure to create FILE, error if exists\n\
+"), stdout);
+      fputs (_("\
+  -i, --input-stream=FD     read from stream FD instead of standard input\n\
+"), stdout);
+      fputs (_("\n\
+The default input stream number FD is 0, representing the standard input.\n\
+"), stdout);
+      emit_ancillary_info (PROGRAM_NAME);
+    }
+  exit (status);
+}
+
+/* Copy data from file descriptor INFD to file FILENAME.
+   Return true if successful.  */
+
+static bool
+sink (int src_fd, char *filename)
+{
+  char buffer[BUFSIZ];
+  ssize_t bytes_read = 0;
+  bool ok = true;
+
+  xset_binary_mode (src_fd, O_BINARY);
+  fadvise (fdopen (src_fd, "r"), FADVISE_SEQUENTIAL);
+
+  char const *mode_string =
+    (O_BINARY
+     ? (flag_append ? "ab" : "wb")
+     : (flag_append ? "a" : "w"));
+
+  /* Both --append and --create may create the file.  */
+  int open_flags = O_WRONLY | O_BINARY | O_NOCTTY | O_CREAT;
+  if (flag_creat)
+    open_flags |= O_EXCL;
+
+  open_flags |= flag_append ? O_APPEND : O_TRUNC;
+
+  int dest_fd = open (filename, open_flags, MODE_RW_UGO);
+  if (dest_fd < 0)
+    die (EXIT_FAILURE, errno, "%s: %s", _("open failed"), quoteaf (filename));
+
+  FILE *dest_fp = fdopen (dest_fd, mode_string);
+  if (dest_fp == NULL)
+    die (EXIT_FAILURE, errno, "%s", quoteaf (filename));
+
+  setvbuf (dest_fp, NULL, _IONBF, 0);
+
+  while (true)
+    {
+      bytes_read = read (src_fd, buffer, sizeof buffer);
+      if (bytes_read < 0 && errno == EINTR)
+        continue;
+      if (bytes_read <= 0)
+        break;
+
+      if (fwrite (buffer, bytes_read, 1, dest_fp) != 1)
+        die (EXIT_FAILURE, errno, "%s: %s", _("write failed"),
+             quoteaf (filename));
+    }
+
+  if (bytes_read == -1)
+    die (EXIT_FAILURE, errno, _("file descriptor %d: read failed"), src_fd);
+
+  if (close (src_fd) != 0)
+    die (EXIT_FAILURE, errno, _("file descriptor %d: close failed"), src_fd);
+
+  if (fclose (dest_fp) != 0)
+    die (EXIT_FAILURE, errno, "%s: %s", _("close failed"), quoteaf (filename));
+
+  return ok;
+}
+
+int
+main (int argc, char **argv)
+{
+  int optc;
+
+  initialize_main (&argc, &argv);
+  set_program_name (argv[0]);
+  setlocale (LC_ALL, "");
+  bindtextdomain (PACKAGE, LOCALEDIR);
+  textdomain (PACKAGE);
+
+  atexit (close_stdout);
+
+  flag_append = false;
+
+  while ((optc = getopt_long (argc, argv, "aci:", long_options, NULL)) != -1)
+    {
+      switch (optc)
+        {
+        case 'a':
+          flag_append = true;
+          break;
+
+        case 'c':
+          flag_creat = true;
+          break;
+
+        case 'i':
+          input_stream = xdectoimax (optarg , 0, OPEN_MAX_MAX, "",
+                                     _("invalid input stream number"), 0);
+          break;
+
+        case_GETOPT_HELP_CHAR;
+
+        case_GETOPT_VERSION_CHAR (PROGRAM_NAME, AUTHORS);
+
+        default:
+          usage (EXIT_FAILURE);
+        }
+    }
+
+  if (argc <= optind)
+    {
+      error (0, 0, _("missing operand"));
+      usage (EXIT_FAILURE);
+    }
+
+  if (1 < argc - optind)
+    {
+      error (0, 0, _("extra operand: %s"), quoteaf (argv[optind + 1]));
+      usage (EXIT_FAILURE);
+    }
+
+  bool ok = sink (input_stream, argv[optind]);
+
+  return ok ? EXIT_SUCCESS : EXIT_FAILURE;
+}
diff --git a/tests/local.mk b/tests/local.mk
index d3cfbcd02..c724c9630 100644
--- a/tests/local.mk
+++ b/tests/local.mk
@@ -359,6 +359,7 @@ all_tests =					\
   tests/misc/shred-size.sh			\
   tests/misc/shuf.sh				\
   tests/misc/shuf-reservoir.sh			\
+  tests/misc/sink.sh				\
   tests/misc/sleep.sh				\
   tests/misc/sort.pl				\
   tests/misc/sort-benchmark-random.sh		\
diff --git a/tests/misc/help-version.sh b/tests/misc/help-version.sh
index 17d4c7032..04ca3432f 100755
--- a/tests/misc/help-version.sh
+++ b/tests/misc/help-version.sh
@@ -195,6 +195,7 @@ logname_setup () { args=--version; }
 nohup_setup () { args=--version; }
 printf_setup () { args=foo; }
 seq_setup () { args=10; }
+sink_setup () { args=$tmp_out; }
 sleep_setup () { args=0; }
 stdbuf_setup () { args="-oL true"; }
 timeout_setup () { args=--version; }
diff --git a/tests/misc/sink.sh b/tests/misc/sink.sh
new file mode 100755
index 000000000..395cbbc29
--- /dev/null
+++ b/tests/misc/sink.sh
@@ -0,0 +1,146 @@
+#!/bin/sh
+# test for basic sink functionality.
+
+# Copyright (C) 2021 Free Software Foundation, Inc.
+
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 3 of the License, or
+# (at your option) any later version.
+
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <https://www.gnu.org/licenses/>.
+
+. "${srcdir=.}/tests/init.sh"; path_prepend_ ./src
+print_ver_ sink
+
+echo line >sample || framework_failure_
+
+# Simple run.
+sink file <sample >out 2>err || fail=1
+compare sample file || fail=1
+compare /dev/null out || fail=1
+compare /dev/null err || fail=1
+
+# No FILE given.
+returns_ 1 sink <sample >out 2>err || fail=1
+compare /dev/null out || fail=1
+grep 'missing operand' err || { cat err; fail=1; }
+
+# Extra operand.
+returns_ 1 sink file extra <sample >out 2>err || fail=1
+compare /dev/null out || fail=1
+grep 'extra operand' err || { cat err; fail=1; }
+
+# Test -a, --append.
+for o in -a --append; do
+  rm -f file out err || framework_failure_
+
+  # New file: -a does nothing special.
+  sink $o file <sample >out 2>err || fail=1
+  compare sample file || fail=1
+  compare /dev/null out || fail=1
+  compare /dev/null err || fail=1
+
+  # remove out+err.
+  rm -f out err || framework_failure_
+  # prepare file to append.
+  echo survived > file || framework_failure_
+  { echo survived; echo line; } > exp || framework_failure_
+
+  # Test the EEXIST case.
+  sink $o file <sample >out 2>err || fail=1
+  compare exp file || fail=1
+  compare /dev/null out || fail=1
+  compare /dev/null err || fail=1
+done
+rm -f file exp out err || framework_failure_
+
+# Test -c, --create.
+for o in -c --create; do
+  rm -f file out err || framework_failure_
+
+  sink $o file <sample >out 2>err || fail=1
+  compare sample file || fail=1
+  compare /dev/null out || fail=1
+  compare /dev/null err || fail=1
+
+  # keep file, remove out+err.
+  rm -f out err || framework_failure_
+
+  # Test the EEXIST case.
+  returns_ 1 sink $o file <sample >out 2>err || fail=1
+  compare /dev/null out || fail=1
+  grep exist err || fail=1
+
+  # remove file, out+err.
+  rm -f file our err || framework_failure_
+
+  # Test --create with --append: append is a noop.
+  sink $o -a file <sample >out 2>err || fail=1
+  compare sample file || fail=1
+  compare /dev/null out || fail=1
+  compare /dev/null err || fail=1
+done
+rm -f in file out err || framework_failure_
+
+# Test -i, --input-stream.
+for o in -i --input-stream; do
+  # Exercise FD=0 (=stdin).
+  sink $o 0 file <sample >out 2>err || fail=1
+  compare sample file || fail=1
+  compare /dev/null out || fail=1
+  compare /dev/null err || fail=1
+  rm -f file out err || framework_failure_
+
+  # Exercise wit FD=18.
+  echo other >in || framework_failure_
+  sink $o 18 file <in 18<sample >out 2>err || fail=1
+  compare sample file || fail=1
+  compare /dev/null out || fail=1
+  compare /dev/null err || fail=1
+  rm -f in file out err || framework_failure_
+done
+
+# Exercise -i with invalid values: negative or non-numeric.
+returns_ 1 sink -i-1 file <sample >out 2>err || fail=1
+grep 'invalid input stream number' err || { cat err; fail=1; }
+
+returns_ 1 sink --input-stream=A file <sample >out 2>err || fail=1
+grep 'invalid input stream number' err || { cat err; fail=1; }
+
+# Exercise -i with EBADF.
+# FD is closed.
+returns_ 1 sink -i18 file 18<&- >out 2>err || fail=1
+compare /dev/null file || fail=1
+compare /dev/null out || fail=1
+grep 'read failed' err || { cat err; fail=1; }
+rm -f file out err || framework_failure_
+
+# FD is open for writing only.
+returns_ 1 sink -i18 file 18>f >out 2>err || fail=1
+compare /dev/null file || fail=1
+compare /dev/null out || fail=1
+grep 'read failed' err || { cat err; fail=1; }
+rm -f file out err || framework_failure_
+
+# Exercise open's EISDIR.
+returns_ 1 sink . <sample >out 2>err || fail=1
+compare /dev/null out || fail=1
+grep 'open failed' err || { cat err; fail=1; }
+rm -f out err || framework_failure_
+
+# Exercise ENOSPC.
+if test -w /dev/full && test -c /dev/full; then
+  yes | returns_ 1 timeout 10 sink /dev/full >err 2>err || fail=1
+  compare /dev/null out || fail=1
+  grep 'write failed' err || { cat err; fail=1; }
+  rm -f err || framework_failure_
+fi
+
+Exit $fail
-- 
2.30.0


--------------74CEB4541933A37E03B2ADF5--
