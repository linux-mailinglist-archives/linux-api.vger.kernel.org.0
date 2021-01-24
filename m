Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E70301E05
	for <lists+linux-api@lfdr.de>; Sun, 24 Jan 2021 18:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbhAXR7T (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 Jan 2021 12:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbhAXR7R (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 Jan 2021 12:59:17 -0500
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Jan 2021 09:58:36 PST
Received: from clue.drijf.net (clue.drijf.net [IPv6:2a02:898::216:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEC6C061573
        for <linux-api@vger.kernel.org>; Sun, 24 Jan 2021 09:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drijf.net; s=default;
        t=1611510710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6R9cxIIPJyVqbiYIwH3/tA/8c+6DhQciQFD9pBBqCaw=;
        b=dbWXWjPLe6u3ZvDorGvYtUhIlXOFmBV019x+6pShnH8uaVO1hK0XStDOnaXRQGDfMYb//m
        7l4NV5JrDuD04Ih/HKSxhVZ+EAlMmse+MCtI+AQ2L6Kuq0tAuVB8GZfipy82zQzWPFJN5G
        h56U6zHDVb0LCPd4JbJn+wIQaKHo9y4=
Received: from clue.drijf.net (clue.drijf.net [94.142.244.34])
        by mx1.drijf.net (OpenSMTPD) with ESMTPSA id 30a2f150 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 24 Jan 2021 18:51:50 +0100 (CET)
Date:   Sun, 24 Jan 2021 18:51:48 +0100
From:   Otto Moerbeek <otto@drijf.net>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Bernhard Voelker <mail@bernhard-voelker.de>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Christian Groessler <chris@groessler.org>,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>,
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
Message-ID: <YA2ztHUATu1gOxoV@clue.drijf.net>
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
 <20210124121845.38293-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124121845.38293-1-alx.manpages@gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Jan 24, 2021 at 01:18:46PM +0100, Alejandro Colomar wrote:

> This is useful for using tee to just write to a file,
> at the end of a pipeline,
> without having to redirect to /dev/null
> 
> Example:
> 
> echo 'foo' | sudo tee -q /etc/foo;
> 
> is equivalent to the old (and ugly)

You keep repeating "ugly" as the reason you are wanting this.

I consider adding special options to command to solve an imagined
issue that can be solved with a general concept like redirection ugly.
Please stop pushing your diff to this list. So far nobody showed any
interest.

	-Otto

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
