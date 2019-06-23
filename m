Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78854F973
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2019 03:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfFWB5Y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 22 Jun 2019 21:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfFWB5Y (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 22 Jun 2019 21:57:24 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8275120820;
        Sun, 23 Jun 2019 01:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561255043;
        bh=DbHELEFktwFIO3TcwhinuOLMWsirGAILkCkazCNQxF0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ODywlkzvGzHGFBC4/svAr8OFCcBLnRE+Vl7UhoSN9FkuYrfIV5AgaKlp1G8acNi4J
         FGnS63WbNnagpHhEsOtq4Pf/Gs7MduY51/RF0xy2IgeeIp0RxtHiE8mbs1U3J/fxDi
         ePBJKSDYvFtzvWwdTwRWVp8B+TyxKBoaQb4kkoQ8=
Date:   Sun, 23 Jun 2019 10:57:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH V34 22/29] Lock down tracing and perf kprobes when in
 confidentiality mode
Message-Id: <20190623105717.7a22195ea66f276c38ae5096@kernel.org>
In-Reply-To: <20190622000358.19895-23-matthewgarrett@google.com>
References: <20190622000358.19895-1-matthewgarrett@google.com>
        <20190622000358.19895-23-matthewgarrett@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 21 Jun 2019 17:03:51 -0700
Matthew Garrett <matthewgarrett@google.com> wrote:

> From: David Howells <dhowells@redhat.com>
> 
> Disallow the creation of perf and ftrace kprobes when the kernel is
> locked down in confidentiality mode by preventing their registration.
> This prevents kprobes from being used to access kernel memory to steal
> crypto data, but continues to allow the use of kprobes from signed
> modules.

Looks (and sounds) good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: davem@davemloft.net
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  include/linux/security.h     | 1 +
>  kernel/trace/trace_kprobe.c  | 5 +++++
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 3875f6df2ecc..e6e3e2403474 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -96,6 +96,7 @@ enum lockdown_reason {
>  	LOCKDOWN_MMIOTRACE,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_KCORE,
> +	LOCKDOWN_KPROBES,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
>  
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 5d5129b05df7..5a76a0f79d48 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -11,6 +11,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/rculist.h>
>  #include <linux/error-injection.h>
> +#include <linux/security.h>
>  
>  #include "trace_dynevent.h"
>  #include "trace_kprobe_selftest.h"
> @@ -415,6 +416,10 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
>  {
>  	int i, ret;
>  
> +	ret = security_locked_down(LOCKDOWN_KPROBES);
> +	if (ret)
> +		return ret;
> +
>  	if (trace_probe_is_registered(&tk->tp))
>  		return -EINVAL;
>  
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 4c9b324dfc55..5a08c17f224d 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -32,6 +32,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_KCORE] = "/proc/kcore access",
> +	[LOCKDOWN_KPROBES] = "use of kprobes",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
