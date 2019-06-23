Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE374F959
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2019 02:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfFWAMj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 22 Jun 2019 20:12:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42304 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfFWAMi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 22 Jun 2019 20:12:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so4783969plb.9
        for <linux-api@vger.kernel.org>; Sat, 22 Jun 2019 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Prscc723sZ8+qgLRikcBsfIq/Y6O5wzMfYQ/rmLcVTo=;
        b=MIF83eSvmE+KzBBQDt5kUh18cBLWZQ8cuOBZn3drW7IbtW/IuMxvJPVZyjB+GOCtXh
         ocmDzaMX05V/gXlwn3oalZ0AqGf37Q8D/oWMVTTULJaBstqxXme69M3xjNGZOo3TvUOv
         dPM9n6PjrE0p37Aqr5G5DHJXWUdzG+qDHtqco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Prscc723sZ8+qgLRikcBsfIq/Y6O5wzMfYQ/rmLcVTo=;
        b=JkkwHfxmwR2h5mroXWN56qQ487g5hmS6aPJJZMuV4cwxfwfTz4Gxj7ATjij4+UHGs8
         21y88RzaFdXudusI2DcQ0YdfJSIa/nztnLLGSiElT46jz+ltOxZZIVBCzTgb4ZoqKv3W
         ALn1DnwjFgPbbzT/s2DI9z98qSKGN9DtPgR4v0dtGN+T3JFPZvlFxRPvxo2uKrWnQvvA
         ulZfvxof4e9cJNxju3IWOTrJifh52qCu5RF29nGHgtLqmGIf6KNxMQyul6Ub5pvGyWLE
         AnKfC2RuJov6CQ7lqr8z5IDvxvxZKzJXREALrBB4PMYL+5rEz/qi2B2wWvFudm2t6CvH
         Votg==
X-Gm-Message-State: APjAAAX61YRLA+EBW5fvQDq2JJwpmX/epkBk6SHJdJhthIelj1wxdmoR
        C3SSJJ3giC9Hk9Hg4vN8wQEiFg==
X-Google-Smtp-Source: APXvYqxynlEEoCNBU0g47FTrctp/uDLj/obZe/1CCXNGszBCqYKsw3srBoOfwhdjiKMKikhoKYqgwA==
X-Received: by 2002:a17:902:7b84:: with SMTP id w4mr30044455pll.22.1561248758334;
        Sat, 22 Jun 2019 17:12:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n89sm30709882pjc.0.2019.06.22.17.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 17:12:37 -0700 (PDT)
Date:   Sat, 22 Jun 2019 17:12:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH V34 24/29] Lock down perf when in confidentiality mode
Message-ID: <201906221710.EB0540F@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-25-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-25-matthewgarrett@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:53PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Disallow the use of certain perf facilities that might allow userspace to
> access kernel data.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> ---
>  include/linux/security.h     | 1 +
>  kernel/events/core.c         | 7 +++++++
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index de0d37b1fe79..53ea85889a48 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -98,6 +98,7 @@ enum lockdown_reason {
>  	LOCKDOWN_KCORE,
>  	LOCKDOWN_KPROBES,
>  	LOCKDOWN_BPF_READ,
> +	LOCKDOWN_PERF,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
>  
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 72d06e302e99..77f36551756e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10731,6 +10731,13 @@ SYSCALL_DEFINE5(perf_event_open,
>  			return -EINVAL;
>  	}
>  
> +	err = security_locked_down(LOCKDOWN_PERF);
> +	if (err && (attr.sample_type & PERF_SAMPLE_REGS_INTR))
> +		/* REGS_INTR can leak data, lockdown must prevent this */
> +		return err;
> +	else
> +		err = 0;
> +
>  	/* Only privileged users can get physical addresses */
>  	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
>  	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))

With moar capable() ordering fixed...

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 2eea2cc13117..a7e75c614416 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -34,6 +34,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_KCORE] = "/proc/kcore access",
>  	[LOCKDOWN_KPROBES] = "use of kprobes",
>  	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
> +	[LOCKDOWN_PERF] = "unsafe use of perf",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
