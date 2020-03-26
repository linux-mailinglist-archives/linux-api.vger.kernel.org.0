Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABB37193FBF
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 14:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgCZN3x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 09:29:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:43694 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgCZN3x (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 26 Mar 2020 09:29:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 297B4AC77;
        Thu, 26 Mar 2020 13:29:51 +0000 (UTC)
Subject: Re: [RFC v2 1/2] kernel/sysctl: support setting sysctl parameters
 from kernel command line
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <874kuc5b5z.fsf@x220.int.ebiederm.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a551765c-829c-187a-efe5-31caab1d3ac1@suse.cz>
Date:   Thu, 26 Mar 2020 14:29:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <874kuc5b5z.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/25/20 11:20 PM, Eric W. Biederman wrote:
> Vlastimil Babka <vbabka@suse.cz> writes:
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -1980,6 +1980,68 @@ int __init sysctl_init(void)
>>  	return 0;
>>  }
>>  
>> +/* Set sysctl value passed on kernel command line. */
>> +int process_sysctl_arg(char *param, char *val,
>> +			       const char *unused, void *arg)
>> +{
>> +	size_t count;
>> +	char *remaining;
>> +	int err;
>> +	loff_t ppos = 0;
>> +	struct ctl_table *ctl, *found = NULL;
>> +
>> +	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
>> +		return 0;
> 
> Is there any way we can use a slash separated path.  I know

We could, but as others explained, people and tools are used to the dot
separation, so I think the only sensible options are supporting only dot, or
both dot and slash.

> in practice there are not any sysctl names that don't have
> a '.' in them but why should we artifically limit ourselves?

Existing tools would probably break (or perhaps sysctl(8) is smarter than I
think, dunno).

> I guess as long as we don't mind not being able to set sysctls
> that have a '.' in them it doesn't matter.

Right.

>> +
>> +	param += sizeof("sysctl.") - 1;
>> +
>> +	remaining = param;
>> +	ctl = &sysctl_base_table[0];
>> +
>> +	while(ctl->procname != 0) {
>               ^^^^^^^^^^^^^^^^^^
> 
> Please either test "while(ctl->procname)" or
> "while(ctl->procname != NULL)" testing against 0 makes it look like
> procname is an integer.  The style in the kernel is to test against
> NULL, to make it clear when something is a pointer.

OK

>> +		int len = strlen(ctl->procname);
> 
> You should have done "strchr(remaining)" and figured out if there is
> another '.' and only compared up to that dot.  Probably skipping this
> entry entirely if the two lengths don't match.

That's also possible, but AFAICS my code works as intended, as I explained in a
reply to Kees, and also below:

>> +		if (strncmp(remaining, ctl->procname, len)) {
>> +			ctl++;
>> +			continue;
>> +		}
>> +		if (ctl->child) {
>> +			if (remaining[len] == '.') {
>> +				remaining += len + 1;
>> +				ctl = ctl->child;
>> +				continue;
>> +			}
>> +		} else {
>> +			if (remaining[len] == '\0') {
>> +				found = ctl;
>> +				break;
>> +			}
>> +		}
>> +		ctl++;
> 
> There should be exactly one match for a name a table.
> If you get here the code should break, not continue on.

If there existed e.g. both "vm.swap" and "vm.swappiness" options and user passed
"vm.swappiness=10", but the "swap" ctl entry was encountered first, it will
succeed the strncmp(), but then realize "swap" was just a prefix of what user
specified (remaining[len] is not '\0') and hence continue serching for other
matches.

>> +	}
>> +
>> +	if (!found) {
>> +		pr_warn("Unknown sysctl param '%s' on command line", param);
>> +		return 0;
>> +	}
>> +
>> +	if (!(found->mode & 0200)) {
>> +		pr_warn("Cannot set sysctl '%s=%s' from command line - not writable",
>> +			param, val);
>> +		return 0;
>> +	}
>> +
>> +	count = strlen(val);
>> +	err = found->proc_handler(found, 1, val, &count, &ppos);
>> +
>> +	if (err)
>> +		pr_warn("Error %d setting sysctl '%s=%s' from command line",
>> +			err, param, val);
>> +
>> +	pr_debug("Set sysctl '%s=%s' from command line", param, val);
>> +
>> +	return 0;
>> +}
> 
> You really should be able to have this code live in
> fs/proc/proc_sysctl.c and utilize lookup_entry.
> 
> That should give you the ability to lookup any sysctl.  If
> kernel/sysctl.c is compiled into the kernel proc_sysctl.c is compiled
> into the kernel.  Systems that don't select CONFIG_PROC_SYSCTL won't
> have any sysctl tables installed at all so they do not make sense to
> consider or design for.

I see. In fact one reason why I tried to avoid the proc stuff was your commit
61a47c1ad3a4 ("sysctl: Remove the sysctl system call") and this part:

> As this removes one of the few uses of the internal kernel mount
> of proc I hope this allows for even more simplifications of the
> proc filesystem.

But if you now suggest using the kernel mount then sure, it I don't object make
the code simpler and handle all sysctls.

> Further it will be faster to lookup the sysctls using the code from
> proc_sysctl.c as it constructs an rbtree of all of the entries in
> a directory.  The code might as well take advantage of that for large
> directories.
> 
> Arguably the main sysctl tables in kernel/sysctl.c should be split up so
> that things are more localized and there is less global state exported
> throughout the kernel.  I certainly don't want to discourage anyone from
> doing that just so their sysctl can be used on the command line.

Fair point.

> Hmm.  There is a big gotcha in here and I think it should be mentioned.
> This code only works because no one has done set_fs(KERNEL_DS).  Which
> means this only works with strings that are kernel addresses essentially
> by mistake.  A big fat comment documenting why it is safe to pass in
> kernel addresses to a function that takes a "char __user*" pointer
> would be very good.

Thanks, didn't realize that.

> Eric
> 

