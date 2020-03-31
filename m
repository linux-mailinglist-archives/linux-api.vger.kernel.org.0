Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B319198D3E
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2020 09:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgCaHmu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 31 Mar 2020 03:42:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:54868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgCaHmu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 31 Mar 2020 03:42:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A0A9FAF5C;
        Tue, 31 Mar 2020 07:42:47 +0000 (UTC)
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters from
 kernel command line
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
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
 <20200330115535.3215-2-vbabka@suse.cz>
 <20200330224422.GX11244@42.do-not-panic.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8146e3d0-89c3-7f79-f786-084c58282c85@suse.cz>
Date:   Tue, 31 Mar 2020 09:42:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330224422.GX11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/31/20 12:44 AM, Luis Chamberlain wrote:
> Sorry to be late to the apocalypse review party for this, feedback below.
> 
> On Mon, Mar 30, 2020 at 01:55:33PM +0200, Vlastimil Babka wrote:
>> A recently proposed patch to add vm_swappiness command line parameter in
>> addition to existing sysctl [1] made me wonder why we don't have a general
>> support for passing sysctl parameters via command line. Googling found only
>> somebody else wondering the same [2], but I haven't found any prior discussion
>> with reasons why not to do this.
>> 
>> Settings the vm_swappiness issue aside (the underlying issue might be solved in
>> a different way), quick search of kernel-parameters.txt shows there are already
>> some that exist as both sysctl and kernel parameter - hung_task_panic,
>> nmi_watchdog, numa_zonelist_order, traceoff_on_warning. A general mechanism
>> would remove the need to add more of those one-offs and might be handy in
>> situations where configuration by e.g. /etc/sysctl.d/ is impractical.
>> 
>> Hence, this patch adds a new parse_args() pass that looks for parameters
>> prefixed by 'sysctl.' and tries to interpret them as writes to the
>> corresponding sys/ files using an temporary in-kernel procfs mount. This
>> mechanism was suggested by Eric W. Biederman [3], as it handles all dynamically
>> registered sysctl tables.
> 
> "even though we don't handle modular sysctls" might be safer to add.

OK

>> Errors due to e.g. invalid parameter name or value
>> are reported in the kernel log.
>> 
>> The processing is hooked right before the init process is loaded, as some
>> handlers might be more complicated than simple setters and might need some
>> subsystems to be initialized. At the moment the init process can be started and
>> eventually execute a process writing to /proc/sys/ then it should be also fine
>> to do that from the kernel.
> 
> This is wonderful when we think about existing sysctls which have
> corresponding silly boot params that do the same thing. However, shoving
> a boot param capability down every possible built-in sysctl brings
> forward support considerations we should take serious, as this would
> add a new user interface and we'll have to support it.

Hmm, if I boot with an initramfs with init process that does mount /proc and set
some sysctl there as the very first thing, then this will be almost the same
moment as my patch does it. There is no further kernel initialization in
between. So with your logic we already do support all non-modular sysctls to be
set so early.

> Simply put, not all sysctls should be born to be boot params. I suggest
> we white-list which ones we can process, so that only sysctls we *do*
> review and agree are good candidates get allowed to also be boot params.

By above, the nuber of sysctls that will be problematic with this boot param
mechanism, but work properly when set from init process immediately, should be
near zero, and I would expect truly zero. As such, whitelist approach seems
excessive to me and it would take a lot of effort to build it, and it will be a
lottery which sysctl would work as boot param on which kernel version. Sounds
like a lot of trouble for little benefit to me.

> Calling a proc hanlder early might seem functional, but if the subsystem
> defers evaluation of a setting later, then any boot param set would be
> lifted anyway.

I'm not sure I understand, can you show me some example please?

> I think each syscl would need to be reviewed for this to
> be supported in a way that doesn't create odd unexpected system settings
> which we later have to support forever.

We would already do per the initramfs argument.

> Should we not do this, we'll have to live with the consequences of
> supporting the full swoop of sysctls are boot params, whatever
> consequences those may be.

Of course when the first user tries to set some particular sysctl as boot param
and finds and reports it doesn't work as intended, then it can be fixed or
blacklisted and it can't break anyone else?

>> Sysctls registered later on module load time are not set by this mechanism -
>> it's expected that in such scenarios, setting sysctl values from userspace is
>> practical enough.
> 
> I'm just not sure if its worth supporting these, for modules we have
> module params, but those with more creative userspace might have a
> better idea as to why we'd want to support this. I just can't see it
> yet.

Sure, I can defer that part for later now.

>> [1] https://lore.kernel.org/r/BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com/
>> [2] https://unix.stackexchange.com/questions/558802/how-to-set-sysctl-using-kernel-command-line-parameter
>> [3] https://lore.kernel.org/r/87bloj2skm.fsf@x220.int.ebiederm.org/
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---

> 

