Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A266301D7A
	for <lists+linux-api@lfdr.de>; Sun, 24 Jan 2021 17:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbhAXQYd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 Jan 2021 11:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbhAXQYc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 Jan 2021 11:24:32 -0500
X-Greylist: delayed 684 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Jan 2021 08:23:46 PST
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0644EC061573
        for <linux-api@vger.kernel.org>; Sun, 24 Jan 2021 08:23:46 -0800 (PST)
Received: from [174.126.29.109] (port=59666 helo=localhost)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <sega01@go-beyond.org>)
        id 1l3hza-0007wT-1G; Sun, 24 Jan 2021 16:11:59 +0000
Date:   Sun, 24 Jan 2021 16:11:34 +0000
From:   Teran McKinney <sega01@go-beyond.org>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Bernhard Voelker <mail@bernhard-voelker.de>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Christian Groessler <chris@groessler.org>,
        P??draig Brady <P@draigbrady.com>,
        Coreutils <coreutils@gnu.org>,
        William Ahern <william@25thandclement.com>,
        Erik Auerswald <auerswal@unix-ag.uni-kl.de>,
        Eric Pruitt <eric.pruitt@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Fabrice BAUZAC <noon@mykolab.com>, tech@openbsd.org,
        freebsd-hackers@freebsd.org, linux-api@vger.kernel.org,
        juli@clockworksquid.com, ed@nuxi.nl, oshogbo@freebsd.org
Subject: Re: [PATCH v3 (resend)] tee: Add -q, --quiet, --silent option to not
 write to stdout
Message-ID: <YA2cNr/BQw1fAhwn@daemon>
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
 <20210124121845.38293-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124121845.38293-1-alx.manpages@gmail.com>
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2021-01-24 13-18-46    , Alejandro Colomar wrote:
> This is useful for using tee to just write to a file,
> at the end of a pipeline,
> without having to redirect to /dev/null
> 
> Example:
> 
> echo 'foo' | sudo tee -q /etc/foo;
> 
> is equivalent to the old (and ugly)
> 
> echo 'foo' | sudo tee /etc/foo >/dev/null;
> 
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> ---
> 
> Resend as v3. I forgot to change the subject line.
> Everything else is the same as in
> <20210123145356.53962-1-alx.manpages@gmail.com>.
> 
>  src/tee.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/src/tee.c b/src/tee.c
> index c81faea91..1dfa92cf2 100644
> --- a/src/tee.c
> +++ b/src/tee.c
> @@ -45,6 +45,9 @@ static bool append;
>  /* If true, ignore interrupts. */
>  static bool ignore_interrupts;
>  
> +/* Don't write to stdout */
> +static bool quiet;
> +
>  enum output_error
>    {
>      output_error_sigpipe,      /* traditional behavior, sigpipe enabled.  */
> @@ -61,6 +64,8 @@ static struct option const long_options[] =
>    {"append", no_argument, NULL, 'a'},
>    {"ignore-interrupts", no_argument, NULL, 'i'},
>    {"output-error", optional_argument, NULL, 'p'},
> +  {"quiet", no_argument, NULL, 'q'},
> +  {"silent", no_argument, NULL, 'q'},
>    {GETOPT_HELP_OPTION_DECL},
>    {GETOPT_VERSION_OPTION_DECL},
>    {NULL, 0, NULL, 0}
> @@ -93,6 +98,7 @@ Copy standard input to each FILE, and also to standard output.\n\
>  "), stdout);
>        fputs (_("\
>    -p                        diagnose errors writing to non pipes\n\
> +  -q, --quiet, --silent     don't write to standard output\n\
>        --output-error[=MODE]   set behavior on write error.  See MODE below\n\
>  "), stdout);
>        fputs (HELP_OPTION_DESCRIPTION, stdout);
> @@ -130,8 +136,9 @@ main (int argc, char **argv)
>  
>    append = false;
>    ignore_interrupts = false;
> +  quiet = false;
>  
> -  while ((optc = getopt_long (argc, argv, "aip", long_options, NULL)) != -1)
> +  while ((optc = getopt_long (argc, argv, "aipq", long_options, NULL)) != -1)
>      {
>        switch (optc)
>          {
> @@ -151,6 +158,10 @@ main (int argc, char **argv)
>              output_error = output_error_warn_nopipe;
>            break;
>  
> +        case 'q':
> +          quiet = true;
> +          break;
> +
>          case_GETOPT_HELP_CHAR;
>  
>          case_GETOPT_VERSION_CHAR (PROGRAM_NAME, AUTHORS);
> @@ -235,8 +246,9 @@ tee_files (int nfiles, char **files)
>          break;
>  
>        /* Write to all NFILES + 1 descriptors.
> -         Standard output is the first one.  */
> -      for (i = 0; i <= nfiles; i++)
> +         Standard output is the first one.
> +         If 'quiet' is true, write to descriptors 1 and above (omit stdout)  */
> +      for (i = quiet; i <= nfiles; i++)
>          if (descriptors[i]
>              && fwrite (buffer, bytes_read, 1, descriptors[i]) != 1)
>            {
> -- 
> 2.30.0
> 
> _______________________________________________
> freebsd-hackers@freebsd.org mailing list
> https://lists.freebsd.org/mailman/listinfo/freebsd-hackers
> To unsubscribe, send any mail to "freebsd-hackers-unsubscribe@freebsd.org"

Hi,

Why is this a thing?

The point of tee is to write a file *and* to stdout. If you don't want use that, use:

`> file`

To overwrite.

Or

`>> file`

To append.

I guess the only reason this would be used is if you wanted to write
multiple files at the same time, which tee supports.

-Teran
