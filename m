Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9346B190207
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2020 00:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCWXkE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Mar 2020 19:40:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCWXkD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Mar 2020 19:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=7b0sNlPhsgzfNj3PIDDNNjIWRJba+EejUPTeNsIBEVs=; b=lylUgvtj511QqIOAomQV4LIcY9
        HyT+1myA6bmTo9wr2vnYspwQOQay5TqvBNW2NK+zjb9TunKB7xYX08xoEnocjrtxoXuCHwp0tyZ1+
        kEnxgVZzHtNfOqFrx2zqAgzixjsReEJmd86iTiOJDXIZzcjX0CY7J7Or07GyDYSG2+m6yoDSnAgyH
        2jW0UaQ/iCQWSHUWEG8nOGjeYGaROWxWlZZ+ySJHui0fAa0O6yCerlfDwJJQs+VMxNZSQ0xrPRVOO
        sWerISru79qbUen+l8jp4A2KlbaRS5QsvjjdbZkcQuNf7qaLGuQZNKxtAbi8GT+bduSIoJd0bbPh4
        iH6Xc/0g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGWfr-0008O0-6E; Mon, 23 Mar 2020 23:40:03 +0000
Subject: Re: [PATCH V2] panic: Add sysctl/cmdline to dump all CPUs backtraces
 on oops event
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, tglx@linutronix.de,
        akpm@linux-foundation.org, linux-api@vger.kernel.org,
        willy@infradead.org, kernel@gpiccoli.net
References: <20200323223035.29891-1-gpiccoli@canonical.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f13d3c11-9a04-3c09-a514-4382c0eb91e8@infradead.org>
Date:   Mon, 23 Mar 2020 16:40:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323223035.29891-1-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi-
(same)

On 3/23/20 3:30 PM, Guilherme G. Piccoli wrote:

> 
> V2: Implemented grammar suggestions from Randy, Andrew and
> Matthew. Thanks in advance for the reviews!
> Cheers,
> 
> Guilherme
> 
> 
>  .../admin-guide/kernel-parameters.txt         |  8 +++++++
>  Documentation/admin-guide/sysctl/kernel.rst   | 17 +++++++++++++++
>  include/linux/kernel.h                        |  6 ++++++
>  kernel/panic.c                                | 21 +++++++++++++++++++
>  kernel/sysctl.c                               | 11 ++++++++++
>  5 files changed, 63 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7a14caac6c94..7db622028c00 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3333,6 +3333,14 @@
>  			This will also cause panics on machine check exceptions.
>  			Useful together with panic=30 to trigger a reboot.
>  
> +	oops_all_cpu_backtrace=
> +			[KNL] Should kernel generate backtraces on all cpus

			                                               CPUs

> +			when oops occurs - this should be a last measure resort
> +			in case	a kdump cannot be collected, for example.
> +			Defaults to 0 and can be controlled by the sysctl
> +			kernel.oops_all_cpu_backtrace.
> +			Format: <integer>
> +
>  	page_alloc.shuffle=
>  			[KNL] Boolean flag to control whether the page allocator
>  			should randomize its free lists. The randomization may
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 8b4ff69d2348..8660001d3a3e 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -57,6 +57,7 @@ show up in /proc/sys/kernel:
>  - msgmnb
>  - msgmni
>  - nmi_watchdog
> +- oops_all_cpu_backtrace
>  - osrelease
>  - ostype
>  - overflowgid
> @@ -572,6 +573,22 @@ numa_balancing_scan_size_mb is how many megabytes worth of pages are
>  scanned for a given scan.
>  
>  
> +oops_all_cpu_backtrace:
> +================
> +
> +If this option is set, the kernel will send an NMI to all CPUs to dump
> +their backtraces when an oops event occurs. It should be used as a last
> +resort in case a panic cannot be triggered (to protect VMs running, for
> +example) or kdump can't be collected. This file shows up if CONFIG_SMP
> +is enabled.
> +
> +0: Won't show all CPUs backtraces when an oops is detected.
> +This is the default behavior.
> +
> +1: Will non-maskably interrupt all CPUs and dump their backtraces when
> +an oops event is detected.
> +
> +
>  osrelease, ostype & version:
>  ============================
>  
thanks.

-- 
~Randy

