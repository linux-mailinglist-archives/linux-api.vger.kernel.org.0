Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1FA178C65
	for <lists+linux-api@lfdr.de>; Wed,  4 Mar 2020 09:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgCDINB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Mar 2020 03:13:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:54232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgCDINB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Mar 2020 03:13:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 034F3B1BD;
        Wed,  4 Mar 2020 08:12:58 +0000 (UTC)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_1/2=5d_mm/compaction=3a_Really_limit_compa?=
 =?UTF-8?Q?ct=5funevictable=5fallowed_to_0=e2=80=a61?=
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux API <linux-api@vger.kernel.org>
References: <20200115161035.893221-1-bigeasy@linutronix.de>
 <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
 <20200302173516.iysuejilava37psk@linutronix.de>
 <20200302132531.59a2c9dffe2515d78abaf909@linux-foundation.org>
 <20200303175910.ichnkjkgmz5y2ipb@linutronix.de>
 <20200303202054.gsosv7fsx2ma3cic@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2b790b60-72a7-54b9-aa13-42a160c9aa99@suse.cz>
Date:   Wed, 4 Mar 2020 09:12:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303202054.gsosv7fsx2ma3cic@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/3/20 9:20 PM, Sebastian Andrzej Siewior wrote:
> The proc file `compact_unevictable_allowed' should allow 0 and 1 only,
> the `extra*' attribues have been set properly but without
> proc_dointvec_minmax() as the `proc_handler' the limit will not be
> enforced.
> 
> Use proc_dointvec_minmax() as the `proc_handler' to enfoce the valid
> specified range.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ad5b88a53c5a8..982203101f961 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1484,7 +1484,7 @@ static struct ctl_table vm_table[] = {
>  		.data		= &sysctl_compact_unevictable_allowed,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> 

