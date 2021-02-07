Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9652312156
	for <lists+linux-api@lfdr.de>; Sun,  7 Feb 2021 05:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBGEmP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 6 Feb 2021 23:42:15 -0500
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:53118 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229561AbhBGEmP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 6 Feb 2021 23:42:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3E2321800B884;
        Sun,  7 Feb 2021 04:41:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:1:2:41:355:379:599:960:966:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:2196:2199:2393:2538:2559:2562:2692:2828:2892:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3874:3890:4052:4250:4321:4385:4470:4605:5007:6119:6691:6742:7652:7903:7904:7974:9121:9592:10004:10848:11026:11232:11233:11473:11658:11783:11914:12043:12291:12294:12295:12296:12297:12438:12555:12683:12740:12895:12986:13439:13894:14659:14799:21080:21325:21451:21611:21627:21939:21990:30003:30029:30034:30046:30054:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rub65_500c2a1275f3
X-Filterd-Recvd-Size: 10445
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun,  7 Feb 2021 04:41:30 +0000 (UTC)
Message-ID: <dc6cf90d978e012b0d698a698935d526ca4b0a1c.camel@perches.com>
Subject: Re: [PATCH] printk: Userspace format enumeration support
From:   Joe Perches <joe@perches.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
Date:   Sat, 06 Feb 2021 20:41:29 -0800
In-Reply-To: <YB8IcCqOJA7vzqiJ@chrisdown.name>
References: <YBwU0G+P0vb9wTwm@chrisdown.name> <YB11jybvFCb95S9e@alley>
         <YB3Fwh827m0F+y3n@chrisdown.name>
         <49124db60cdc88c4e9fcca1bbc9767432ad5a93b.camel@perches.com>
         <YB8IcCqOJA7vzqiJ@chrisdown.name>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, 2021-02-06 at 21:21 +0000, Chris Down wrote:
> Joe Perches writes:
> > On Fri, 2021-02-05 at 22:25 +0000, Chris Down wrote:
> > > Petr Mladek writes:
> > > >   + <module> is already optinaly added by pr_fmt() to the printed strings
> > > >     as:  pr_fmt(): ...
> > > 
> > > pr_fmts are not consistently used across the kernel, and sometimes differ from
> > > the module itself. Many modules don't use it at all, and we also don't have it
> > > for pr_cont. Just picking some random examples:
> > > 
> > >      % grep -av vmlinux /proc/printk_formats | shuf -n 10
> > >      mac80211,6%s: mesh STA %pM switches to channel requiring DFS (%d MHz, width:%d, CF1/2: %d/%d MHz), aborting
> > >      thinkpad_acpi,c N/Athinkpad_acpi,c %dthinkpad_acpi,5thinkpad_acpi: temperatures (Celsius):thinkpad_acpi,3thinkpad_acpi: Out of memory for LED data
> > 
> > I don't understand this format.
> > 
> > "Out of memory for LED data" is a single printk ending with a '\n' newline
> > I expected this to be broken up into multiple lines, one for each printk
> > that endsd in a newline.
> 
> Hmm, that's just a manifestation of directly using `shuf` without doing the 
> transformation of trailing nulls to newlines shown in the changelog. They are 
> still distinct and separated by nulls.
> 
> > And what would happen if the function was refactored removing the pr_cont
> > uses like the below: (basically, any output that uses a mechanism that
> > aggregates a buffer then emits it, and there are a _lot_ of those)
> > 
> > 	printk("%s\n", buffer);
> 
> There are certainly printks which can't be trivially monitored using the printk 
> format alone, but the vast majority of the ones that are monitored _do_ have 
> meaningful formats and can be monitored over time. No solution to this is going 
> to catch every single case, especially when so much of the information can be 
> generated dyamically, but this patchset still goes a long way to making printk 
> monitoring more tractable for use cases like the one described in the 
> changelog.

For the _vast_ majority of printk strings, this can easily be found
and compared using a trivial modification to strings.

Module specific formats are stored in the .ko files and could be
examined separately.

Here's the possible patch to strings:

---
 binutils/strings.c | 98 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 16 deletions(-)

diff --git a/binutils/strings.c b/binutils/strings.c
index 3444fbc7222..d4abeb0cdbb 100644
--- a/binutils/strings.c
+++ b/binutils/strings.c
@@ -26,6 +26,10 @@
    --data
    -d		Scan only the initialized data section(s) of object files.
 
+   --section=<section>
+   -S <section> Scan only the specific section(s)
+   --kernel
+   -k		Scan only linux-kernel KERN_SOH strings
    --print-file-name
    -f		Print the name of the file before each string.
 
@@ -108,6 +112,14 @@ static bfd_boolean print_filenames;
 /* TRUE means for object files scan only the data section.  */
 static bfd_boolean datasection_only;
 
+/* TRUE means for object files scan only the specified sections.  */
+static bfd_boolean specified_sections_only;
+static int specified_sections_count;
+static char **specified_sections;
+
+/* TRUE means scan only linux-kernel printk strings with KERN_SOH.  */
+static bfd_boolean linux_kernel_soh;
+
 /* The BFD object file format.  */
 static char *target;
 
@@ -122,6 +134,8 @@ static struct option long_options[] =
 {
   {"all", no_argument, NULL, 'a'},
   {"data", no_argument, NULL, 'd'},
+  {"section", required_argument, NULL, 'S'},
+  {"kernel", no_argument, NULL, 'k'},
   {"print-file-name", no_argument, NULL, 'f'},
   {"bytes", required_argument, NULL, 'n'},
   {"radix", required_argument, NULL, 't'},
@@ -173,7 +187,7 @@ main (int argc, char **argv)
   encoding = 's';
   output_separator = NULL;
 
-  while ((optc = getopt_long (argc, argv, "adfhHn:wot:e:T:s:Vv0123456789",
+  while ((optc = getopt_long (argc, argv, "adS:s:kfhHn:wot:e:T:s:Vv0123456789",
 			      long_options, (int *) 0)) != EOF)
     {
       switch (optc)
@@ -186,6 +200,17 @@ main (int argc, char **argv)
 	  datasection_only = TRUE;
 	  break;
 
+	case 'S':
+	  specified_sections_only = TRUE;
+	  specified_sections = xrealloc(specified_sections,
+					(specified_sections_count + 1) * sizeof(const char *));
+	  specified_sections[specified_sections_count++] = optarg;
+	  break;
+
+	case 'k':
+	  linux_kernel_soh = TRUE;
+	  break;
+
 	case 'f':
 	  print_filenames = TRUE;
 	  break;
@@ -318,6 +343,19 @@ main (int argc, char **argv)
   return (exit_status);
 }
 
+static bfd_boolean
+section_is_specified_section (asection *sect)
+{
+  int i;
+  for (i = 0; i < specified_sections_count; i++)
+    {
+      if (strcmp(specified_sections[i], sect->name) == 0) {
+	return TRUE;
+    }
+  }
+  return FALSE;
+}
+
 /* Scan section SECT of the file ABFD, whose printable name is
    FILENAME.  If it contains initialized data set GOT_A_SECTION and
    print the strings in it.  */
@@ -329,7 +367,9 @@ strings_a_section (bfd *abfd, asection *sect, const char *filename,
   bfd_size_type sectsize;
   bfd_byte *mem;
 
-  if ((sect->flags & DATA_FLAGS) != DATA_FLAGS)
+  if (specified_sections_only && !section_is_specified_section (sect))
+    return;
+  if (datasection_only && ((sect->flags & DATA_FLAGS) != DATA_FLAGS))
     return;
 
   sectsize = bfd_section_size (sect);
@@ -417,7 +457,7 @@ strings_file (char *file)
      try to open it as an object file and only look at
      initialized data sections.  If that fails, fall back to the
      whole file.  */
-  if (!datasection_only || !strings_object_file (file))
+  if (!(datasection_only || specified_sections_only) || !strings_object_file (file))
     {
       FILE *stream;
 
@@ -571,6 +611,7 @@ print_strings (const char *filename, FILE *stream, file_ptr address,
 	       int stop_point, int magiccount, char *magic)
 {
   char *buf = (char *) xmalloc (sizeof (char) * (string_min + 1));
+  int is_kernel = 0;
 
   while (1)
     {
@@ -594,6 +635,7 @@ print_strings (const char *filename, FILE *stream, file_ptr address,
 
 	  if (! STRING_ISGRAPHIC (c))
 	    {
+	      is_kernel = c == 1;
 	      /* Found a non-graphic.  Try again starting with next byte.  */
 	      unget_part_char (c, &address, &magiccount, &magic);
 	      goto tryline;
@@ -601,6 +643,22 @@ print_strings (const char *filename, FILE *stream, file_ptr address,
 	  buf[i] = c;
 	}
 
+      if ((linux_kernel_soh && !is_kernel) ||
+	  (linux_kernel_soh && !strchr("01234567cd", buf[0])))
+	{
+	  while (1) {
+	    c = get_char (stream, &address, &magiccount, &magic);
+	    if (c == EOF)
+	      return;
+	    if (! STRING_ISGRAPHIC (c))
+	      {
+	        unget_part_char (c, &address, &magiccount, &magic);
+	        break;
+	      }
+	    }
+	goto tryline;
+	}
+
       /* We found a run of `string_min' graphic characters.  Print up
 	 to the next non-graphic character.  */
 
@@ -668,8 +726,11 @@ print_strings (const char *filename, FILE *stream, file_ptr address,
 	    break;
 	  }
 
-      buf[i] = '\0';
-      fputs (buf, stdout);
+      if (!linux_kernel_soh || is_kernel)
+        {
+	  buf[i] = '\0';
+	  fputs (buf, stdout);
+        }
 
       while (1)
 	{
@@ -681,13 +742,20 @@ print_strings (const char *filename, FILE *stream, file_ptr address,
 	      unget_part_char (c, &address, &magiccount, &magic);
 	      break;
 	    }
-	  putchar (c);
+	  if (!linux_kernel_soh || is_kernel)
+	    {
+	      putchar (c);
+	    }
 	}
 
-      if (output_separator)
-	fputs (output_separator, stdout);
-      else
-	putchar ('\n');
+      if (!linux_kernel_soh || is_kernel)
+	{
+          if (output_separator)
+	    fputs (output_separator, stdout);
+	  else
+	    putchar ('\n');
+	}
+      is_kernel = 0;
     }
   free (buf);
 }
@@ -702,13 +770,11 @@ usage (FILE *stream, int status)
   if (DEFAULT_STRINGS_ALL)
     fprintf (stream, _("\
   -a - --all                Scan the entire file, not just the data section [default]\n\
-  -d --data                 Only scan the data sections in the file\n"));
-  else
-    fprintf (stream, _("\
+  -d --data                 Only scan the data sections in the file\n\
+  -S --section=[section]    Only scan the specific sections\n\
+  -k --kernel               Only scan for linux-kernel strings with KERN_SOH\n\
   -a - --all                Scan the entire file, not just the data section\n\
-  -d --data                 Only scan the data sections in the file [default]\n"));
-
-  fprintf (stream, _("\
+  -d --data                 Only scan the data sections in the file [default]\n\
   -f --print-file-name      Print the name of the file before each string\n\
   -n --bytes=[number]       Locate & print any NUL-terminated sequence of at\n\
   -<number>                   least [number] characters (default 4).\n\

