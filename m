Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9ACB198CE9
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2020 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCaH1b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 31 Mar 2020 03:27:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:48644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgCaH1b (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 31 Mar 2020 03:27:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 748BCAEA3;
        Tue, 31 Mar 2020 07:27:28 +0000 (UTC)
Subject: Re: [PATCH 3/3] kernel/hung_task convert hung_task_panic boot
 parameter to sysctl
To:     John Hubbard <jhubbard@nvidia.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-4-vbabka@suse.cz> <202003301042.97F3B00@keescook>
 <13ae67d8-4b31-db20-7ba4-1602906a291e@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <37b42835-6c4a-674b-9731-ecc9d0ff1703@suse.cz>
Date:   Tue, 31 Mar 2020 09:27:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <13ae67d8-4b31-db20-7ba4-1602906a291e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/31/20 2:34 AM, John Hubbard wrote:
> On 3/30/20 10:43 AM, Kees Cook wrote:
> ...
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 81ff626fc700..e0b8840404a1 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -1457,7 +1457,7 @@
>>>   			[KNL] Should the hung task detector generate panics.
>>>   			Format: <integer>
>>>   
>>> -			A nonzero value instructs the kernel to panic when a
>>> +			A value of 1 instructs the kernel to panic when a
>>>   			hung task is detected. The default value is controlled
>>>   			by the CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time
>>>   			option. The value selected by this boot parameter can
>>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>>> index 97eb0b552bf8..77b1b844b02b 100644
>>> --- a/fs/proc/proc_sysctl.c
>>> +++ b/fs/proc/proc_sysctl.c
>>> @@ -1743,6 +1743,7 @@ struct sysctl_alias {
>>>    */
>>>   static const struct sysctl_alias sysctl_aliases[] = {
>>>   	{"numa_zonelist_order",		"vm.numa_zonelist_order" },
> 
> 
> Hi Vlastimil,
> 
> Maybe best to delete the above line? Because:
> 
>      a) it was added as an example, and now that you have a real use case in this patch,
>         the example is no longer required, and
> 
>      b) numa_zonelist_order is deprecated, as a boot param. Adding support to it in this
>         brand-new mechanism seems to be going a bit in the opposite direction of deprecation.

Well, this aliases table is not the brand new mechanism, it's just for handling
sysctls that also have a legacy boot param. numa_zonelist_order is such legacy
boot param, so we can handle it here instead of its special handler. If we
decide to remove it later, we can do that, but there is no user-visible effect
on its deprecation by this series.

> And, I don't think you really want all the sysctls to be enabled as boot params, right? Your

The point of Patch 1 is very much so that all sysctls can be set using a boot
param in the form of sysctl.foo.bar=baz

> comment right above sysctl_aliases[] (shown in patch 2) sort of indicates that only some items
> are meant to be both sysctl's and boot params. And that makes sense.

Patches 2+3 are only about handling the legacy boot params that have a sysctl
counterpart.

> In fact, the sysctl_aliases[] is (or could be) effectively the whitelist that Luis Chamberlain
> was requesting in another thread. A whitelist makes good sense, for the reasons Luis listed.
> As such, keeping it limited to items that we want, seems like the way to go, IMHO.

See my reply there once I send it :)

> thanks,
> 

