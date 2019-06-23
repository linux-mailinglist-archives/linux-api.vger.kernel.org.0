Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15B834F948
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2019 02:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFWAEe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 22 Jun 2019 20:04:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44262 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfFWAEe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 22 Jun 2019 20:04:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so5104247pgp.11
        for <linux-api@vger.kernel.org>; Sat, 22 Jun 2019 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dwPVfF+7uosNOxOwAa/pMB1LgjtsAJMQoJ44kFUEf/E=;
        b=d7A6URB/T3MCVmdZfSk8Rj+kUzKExGL0WS/yd3NmfduApD5hvLQr3DP6oUmFGX+Nnw
         OzryFHfHkkGvttb11jsuPDJgYCiecsMscB1zneMBR2Ra7eAB0+88z2yaI41B52xlqpZk
         efjHbgxzQLoLpHlYxqFh8OtrrGuoDC+T0A5uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dwPVfF+7uosNOxOwAa/pMB1LgjtsAJMQoJ44kFUEf/E=;
        b=jmakwirYSMsdaRAGOXlP4Du0s3EDcpQfldzC5S6gj2+sVNy5/WhmIf+OOCmveoUHBu
         kmuCfI8ZNqOynDqNrQ7QO4vG/SlwNZsXXpR+Z+sbELK59qUxtl4qmk9tYt2BxXXOjD6a
         cQvSTF/u4mv69UyDSwU/fS1uYxRze+fkCBYi+FAXM/3F72+3aPU9VrUds7nJ2eX5SQk9
         TQLojDFnNrSne4tKH4wnbbWMU3MoJYLFu6lDA+uiHH+fI+hdPlEcNu7r5Ljs0xNwhRfm
         R5sgEgrs4Kb4XXJsieVXnN94BAffKMjHYwf8AjPceMh9mLR2xpMNGHBU7/oWBxnng0Pd
         jYEg==
X-Gm-Message-State: APjAAAUV/EnRltz1l+y7AJkpQ623ER0DtxLgAieqTlgMPkv2PuPjVORm
        fL7rwSzzK19PNBeYoKurbDWqeA==
X-Google-Smtp-Source: APXvYqwyoNb2Fgd4+yPA4f/daLZR9DpUh+9eujLWHk1+1j+rGdFjc3/5iaM5nH8WBjJHpTMS746IwA==
X-Received: by 2002:a17:90a:b387:: with SMTP id e7mr16074792pjr.113.1561248273637;
        Sat, 22 Jun 2019 17:04:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t4sm15192866pgj.20.2019.06.22.17.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 17:04:32 -0700 (PDT)
Date:   Sat, 22 Jun 2019 17:04:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH V34 20/29] x86/mmiotrace: Lock down the testmmiotrace
 module
Message-ID: <201906221704.495671B@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-21-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-21-matthewgarrett@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:49PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> The testmmiotrace module shouldn't be permitted when the kernel is locked
> down as it can be used to arbitrarily read and write MMIO space. This is
> a runtime check rather than buildtime in order to allow configurations
> where the same kernel may be run in both locked down or permissive modes
> depending on local policy.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: David Howells <dhowells@redhat.com

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Matthew Garrett <mjg59@google.com>
> cc: Thomas Gleixner <tglx@linutronix.de>
> cc: Steven Rostedt <rostedt@goodmis.org>
> cc: Ingo Molnar <mingo@kernel.org>
> cc: "H. Peter Anvin" <hpa@zytor.com>
> cc: x86@kernel.org
> ---
>  arch/x86/mm/testmmiotrace.c  | 5 +++++
>  include/linux/security.h     | 1 +
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
> index f6ae6830b341..6b9486baa2e9 100644
> --- a/arch/x86/mm/testmmiotrace.c
> +++ b/arch/x86/mm/testmmiotrace.c
> @@ -7,6 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/mmiotrace.h>
> +#include <linux/security.h>
>  
>  static unsigned long mmio_address;
>  module_param_hw(mmio_address, ulong, iomem, 0);
> @@ -114,6 +115,10 @@ static void do_test_bulk_ioremapping(void)
>  static int __init init(void)
>  {
>  	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
> +	int ret = security_locked_down(LOCKDOWN_MMIOTRACE);
> +
> +	if (ret)
> +		return ret;
>  
>  	if (mmio_address == 0) {
>  		pr_err("you have to use the module argument mmio_address.\n");
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 88064d7f6827..c649cb91e762 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -93,6 +93,7 @@ enum lockdown_reason {
>  	LOCKDOWN_PCMCIA_CIS,
>  	LOCKDOWN_TIOCSSERIAL,
>  	LOCKDOWN_MODULE_PARAMETERS,
> +	LOCKDOWN_MMIOTRACE,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index d03c4c296af7..cd86ed9f4d4b 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -29,6 +29,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
>  	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
>  	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
> +	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
