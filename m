Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7D1CE2D6
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2020 20:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgEKSb6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 May 2020 14:31:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35059 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbgEKSb6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 May 2020 14:31:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id u15so334420plm.2;
        Mon, 11 May 2020 11:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5XI6huZ8/68IV3V+dfcxfIXPMcxaK1o+Eheo7UEu6z4=;
        b=lbseUWUtIA177l1j/A2RwrX/WqZOw1Ne14yXWO/Nx9FMvnam+qeDQmkvveeVQE2U0C
         iK72CB+2EqrNVxrAC+3SdAPGS8+k2iHeNoQX3YgvVpeYUpZsRU+WUEMuTPLSaDvisJV+
         8Ggc4/t5pCZENrOxQtzFxqT27FqAI4s/SxNe8rKEr2KPc208VaLLmppSEOygJmRuFge+
         osHINdx7ETO/9SM8xtSCgkRT7L2snkEhNiTRzs2R65KeS4buB2Zrgxbbhb7NxoFM1EsN
         nAzjTwMQQzBsp8Px7mKI6MOKPIbxKUAWVlowImdJ0n1+77anoGRffr9SeHWmLksr+TZv
         Qdhg==
X-Gm-Message-State: AGi0PuYu9WXTJFaXJZq1veTWUW9Ilisa/UatWMRJ7S95qgI9Ibr4Pmy+
        u+Q+/ssUK363Co69hywPmp006Zex13Z/4g==
X-Google-Smtp-Source: APiQypJBdyCSHrHdNSwPrrMpX+IeBN7BoplK36lldntx1+VO+CkznBZq/KxCG3ByOwg/kdNYOBuwIA==
X-Received: by 2002:a17:90b:3018:: with SMTP id hg24mr23689052pjb.130.1589221917631;
        Mon, 11 May 2020 11:31:57 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id cp22sm10790760pjb.28.2020.05.11.11.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:31:56 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id ACD8D40605; Mon, 11 May 2020 18:31:55 +0000 (UTC)
Date:   Mon, 11 May 2020 18:31:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 5/5] lib/test_sysctl: support testing of sysctl. boot
 parameter
Message-ID: <20200511183155.GT11244@42.do-not-panic.com>
References: <20200427180433.7029-1-vbabka@suse.cz>
 <20200427180433.7029-6-vbabka@suse.cz>
 <20200427183913.GH11244@42.do-not-panic.com>
 <028d1996-9f4c-20c6-fb2a-706baa919dde@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028d1996-9f4c-20c6-fb2a-706baa919dde@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 11, 2020 at 01:05:22PM +0200, Vlastimil Babka wrote:
> 
> On 4/27/20 8:39 PM, Luis Chamberlain wrote:
> > On Mon, Apr 27, 2020 at 08:04:33PM +0200, Vlastimil Babka wrote:
> > Nice, also we could just require
> > 
> > diff --git a/tools/testing/selftests/sysctl/config b/tools/testing/selftests/sysctl/config
> > index 6ca14800d755..34461cc99a2b 100644
> > --- a/tools/testing/selftests/sysctl/config
> > +++ b/tools/testing/selftests/sysctl/config
> > @@ -1 +1,3 @@
> >  CONFIG_TEST_SYSCTL=y
> > +CONFIG_IKCONFIG=y
> > +CONFIG_IKCONFIG_PROC=y
> > 
> > tools/testing/selftests/firmware/fw_lib.sh then has a kconfig_has()
> > which can verify the exact config.
> 
> Hmm but it also has a (firmware area specific) fallback for case where
> IKCONFIG_PROC doesn't exist. So it's simpler to just keep checking the module
> dir, IMHO, as that would be the fallback. 

As you wish.

> >> +
> >> +	echo -n "Testing if $TARGET is set to 1 ..."
> >> +	ORIG=$(cat "${TARGET}")
> > 
> > This would fail if someone uses this script to test an older kernel, and
> > the scripts in selftests are supposed to work with older kernels.
> 
> Oh, I didn't know that it's supposed to.

Yeap, that's how they are used.

> > One
> > way to address this would be to just see if the file exists first and
> > ignore the test if the $SYSCTL directory exists but the file $TARGET
> > does not.
> > 
> > For now we can just do this:
> > 
> > if [ ! -d $TARGET ]; then
> > 	echo "Skipping test for $TARGET as it is not present ..."
> > 	return 0
> > fi
> 
> OK, just the -d test needs to be fixed :) Andrew can you please apply:
> 
> ----8<----
> From a999e993a89e521b152bbd4b1466f69e62879c30 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Mon, 11 May 2020 12:59:49 +0200
> Subject: [PATCH] lib/test_sysctl: support testing of sysctl. boot parameter -
>  fix
> 
> Skip the new test if boot_int sysctl is not present, otherwise, per Luis,
> "This would fail if someone uses this script to test an older kernel, and
> the scripts in selftests are supposed to work with older kernels."
> 
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  tools/testing/selftests/sysctl/sysctl.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
> index ef6417b8067b..148704f465b5 100755
> --- a/tools/testing/selftests/sysctl/sysctl.sh
> +++ b/tools/testing/selftests/sysctl/sysctl.sh
> @@ -756,6 +756,11 @@ sysctl_test_0006()

You want to:

                                                                                
# Kselftest framework requirement - SKIP code is 4.                             
ksft_skip=4 

>  sysctl_test_0007()
>  {
>  	TARGET="${SYSCTL}/boot_int"
> +	if [ ! -f $TARGET ]; then
> +		echo "Skipping test for $TARGET as it is not present ..."
> +		return 0
> +	fi

And return 4 instead.

  Luis
> +
>  	if [ -d $DIR ]; then
>  		echo "Boot param test only possible sysctl_test is built-in, not module:"
>  		cat $TEST_DIR/config >&2
> -- 
> 2.26.2
> 
