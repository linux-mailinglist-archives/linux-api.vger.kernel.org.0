Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C937E300B37
	for <lists+linux-api@lfdr.de>; Fri, 22 Jan 2021 19:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbhAVS17 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 Jan 2021 13:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbhAVS0A (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 Jan 2021 13:26:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE1C061786
        for <linux-api@vger.kernel.org>; Fri, 22 Jan 2021 10:25:18 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b5so5968205wrr.10
        for <linux-api@vger.kernel.org>; Fri, 22 Jan 2021 10:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yHVmIsGJ1h/LBeJJiJdktlVpTfMOY9z+/xqcZluVyIA=;
        b=CDp2d1rD4vYTG+GA37HcDnd/QhUhBtML4i7BUnTgkrJjMq2zYJruoXjMi250ED2Qbg
         Hpj/J1MtvzzwHbIqjdqsk/LUw3gacZHZK0nHB8ja142SVXyxKx56pLExdNQwKuzhFgYv
         q+8aZHUi9pm9JykjVO5aPVAn8wYSTbUPUcBvyS6Q+D14l38MQFWBS51RwdU6j8qYcJmH
         1Dg4EiGjn1Uk1N+CwW3JEdjP41gkqmChJ7PgEZqyg2ST7jDTnBgrQuKq/gPH0AOJrU0n
         QXLtXCevAJDC2NThtglMrpn1rEu471Wpr4HymqnfV3vjGQa0yjIM900V15CNlgN/e5YB
         N/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHVmIsGJ1h/LBeJJiJdktlVpTfMOY9z+/xqcZluVyIA=;
        b=Uy+WAPcKll9UyfxJFSx48All2POd2rOn/33w3vG0ICQCadFot6mP5bImXq6Q8vvb4E
         00vOrgf+auWdJqTcIvI7yOog57ZCmi95VSVnqDp6MrScfOV1i/4z00Enn9gtrSqYYKb/
         k53hhXeaY2z1Nxh1f53NsUCZ7bNtgqPKMg51A7OX4/2YajyHhPjSIedcnInHGloRNlua
         OnItKq/bVXxPKNnObbEKsBMAu+WqIKGUIImxWo9c3DQyTYYnhCzK1FdIWAIyB09wmPuo
         c3IzmF2qGpqMT3VAcyjpNukGrQpyLS4iOrXHkW+e/e0Gn+Lxp3kvcibFJ1kObvK5oXlp
         Eagw==
X-Gm-Message-State: AOAM530u8h+oGOvCkvYqubyVD3N2BZP/g8wx9HJDH0OUJ6UlJvXFSVLM
        AH35nuaQk1xCzfVQIoy0ESc=
X-Google-Smtp-Source: ABdhPJzJupPV45ouwAllG8Ndffa0cI1AHmop3Xw4yqUWy2Uf14+c4QmpgXetV3tRqWSSf3YLhmJuEw==
X-Received: by 2002:a5d:4cc7:: with SMTP id c7mr5696105wrt.120.1611339916981;
        Fri, 22 Jan 2021 10:25:16 -0800 (PST)
Received: from [192.168.42.141] ([37.29.246.4])
        by smtp.gmail.com with ESMTPSA id t67sm12637466wmt.28.2021.01.22.10.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:25:16 -0800 (PST)
Subject: Re: [PATCH v2] tee: Add -q, --quiet, --silent option to not write to
 stdout
To:     Bernhard Voelker <mail@bernhard-voelker.de>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Christian Groessler <chris@groessler.org>,
        =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigbrady.com>,
        Coreutils <coreutils@gnu.org>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>, noloader@gmail.com,
        Fabrice BAUZAC <noon@mykolab.com>, tech@openbsd.org,
        freebsd-hackers@freebsd.org, linux-api@vger.kernel.org,
        juli@clockworksquid.com, ed@nuxi.nl, oshogbo@FreeBSD.org
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
 <20210121231255.2673075-1-alx.manpages@gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <c9d86909-d9ba-1d3e-6950-fa9d0f6db351@gmail.com>
Date:   Fri, 22 Jan 2021 19:25:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121231255.2673075-1-alx.manpages@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I added a few FreeBSD CCs that I found on their tee.c's git blame, 
because the freebsd list rejects external mail.

Please have a look at the proposal below, and the discussion that 
started on gnu coreutil's list.

On 1/22/21 12:12 AM, Alejandro Colomar wrote:
> This is useful for using tee to just write to a file,
> at the end of a pipeline,
> without having to redirect to /dev/null.
> 
> Example:
> 	echo 'foo' | sudo tee -q /etc/foo;
> is equivalent to the old (and ugly)
> 	echo 'foo' | sudo tee /etc/foo >/dev/null;
> 
> Tools with a similar interface: grep
> 
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> ---
> 
> v2: Add --silent synonym to --quiet, per GNU guidelines.
>      I tested tee --silent with success.
> 
>   src/tee.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/src/tee.c b/src/tee.c
> index c81faea91..68ace983a 100644
> --- a/src/tee.c
> +++ b/src/tee.c
> @@ -45,6 +45,9 @@ static bool append;
>   /* If true, ignore interrupts. */
>   static bool ignore_interrupts;
>   
> +/* Don't write to stdout */
> +static bool quiet;
> +
>   enum output_error
>     {
>       output_error_sigpipe,      /* traditional behavior, sigpipe enabled.  */
> @@ -61,6 +64,8 @@ static struct option const long_options[] =
>     {"append", no_argument, NULL, 'a'},
>     {"ignore-interrupts", no_argument, NULL, 'i'},
>     {"output-error", optional_argument, NULL, 'p'},
> +  {"quiet", no_argument, NULL, 'q'},
> +  {"silent", no_argument, NULL, 'q'},
>     {GETOPT_HELP_OPTION_DECL},
>     {GETOPT_VERSION_OPTION_DECL},
>     {NULL, 0, NULL, 0}
> @@ -93,6 +98,7 @@ Copy standard input to each FILE, and also to standard output.\n\
>   "), stdout);
>         fputs (_("\
>     -p                        diagnose errors writing to non pipes\n\
> +  -q, --quiet, --silent     don't write to standard output\n\
>         --output-error[=MODE]   set behavior on write error.  See MODE below\n\
>   "), stdout);
>         fputs (HELP_OPTION_DESCRIPTION, stdout);
> @@ -130,6 +136,7 @@ main (int argc, char **argv)
>   
>     append = false;
>     ignore_interrupts = false;
> +  quiet = false;
>   
>     while ((optc = getopt_long (argc, argv, "aip", long_options, NULL)) != -1)
>       {
> @@ -151,6 +158,10 @@ main (int argc, char **argv)
>               output_error = output_error_warn_nopipe;
>             break;
>   
> +        case 'q':
> +          quiet = true;
> +          break;
> +
>           case_GETOPT_HELP_CHAR;
>   
>           case_GETOPT_VERSION_CHAR (PROGRAM_NAME, AUTHORS);
> @@ -235,8 +246,9 @@ tee_files (int nfiles, char **files)
>           break;
>   
>         /* Write to all NFILES + 1 descriptors.
> -         Standard output is the first one.  */
> -      for (i = 0; i <= nfiles; i++)
> +         Standard output is the first one.
> +         If 'quiet' is true, write to descriptors 1 and above (omit stdout)  */
> +      for (i = quiet; i <= nfiles; i++)
>           if (descriptors[i]
>               && fwrite (buffer, bytes_read, 1, descriptors[i]) != 1)
>             {
> 


-- 
--
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
