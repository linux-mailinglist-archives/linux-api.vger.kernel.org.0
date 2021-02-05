Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BC23118A9
	for <lists+linux-api@lfdr.de>; Sat,  6 Feb 2021 03:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhBFCnm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 5 Feb 2021 21:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBFCi2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 5 Feb 2021 21:38:28 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D599DC0698C1
        for <linux-api@vger.kernel.org>; Fri,  5 Feb 2021 14:25:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hs11so14597973ejc.1
        for <linux-api@vger.kernel.org>; Fri, 05 Feb 2021 14:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YrUiRYPqSoGiONt4v52Rv4dRTvj5+zwYfGfPMtX2fW8=;
        b=qWuHXWS9WZ2Rlrw6nvL0zLQ3kbQ//jj3uRRygrRkQncrRDmTGFdWvpWNaexf3hBsjp
         7fEsIoFBmG9ttxCQUHMbf7rp0KmTHTZv7S5bDvN7K2b8Jd2EFu1aEsJ7lNhCUIKsZWVZ
         /frepM3qEu/o0yEoIIY5WZV4JlPxDnHQiqxI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YrUiRYPqSoGiONt4v52Rv4dRTvj5+zwYfGfPMtX2fW8=;
        b=F0Ftfx+yjh0g7QTbPrkzWxSuGngmqTDYg9Nkt46ymUWquDGwgv9Se6z0EzEIoq4by+
         vFyC7mF2QG3GbxBm9RhzPuN0L2hHq0tzhZ6+tQNYuncolw8kkTdK0FDOjWQBfLOJUxIL
         yvoVIZkFplbAoSAH0piXTBO9j4EnNvh6FUbOPZu48gYXBVH1y3+Q31flXdbysyPCGQ1D
         oq4iBc/dICIGjefPBak9f2cv8rp+k3p9s95kGSYEzbmpGCL7Ub0rl27hzrdeGNaktiuh
         DdOXRqDQvaD2+wX+kwn6SEEif4Q86w3UaH4OBoM2w/geSCvIXf0JhF9c953shj18oPgq
         eDoQ==
X-Gm-Message-State: AOAM533Fhs0Txhpp/dnuN+CeC6gfe4GeFX9X2esvY36+542185cxxo/P
        2SpRjXMZeZF+8u/C/HehjqYtWQ==
X-Google-Smtp-Source: ABdhPJxZFkkecXefURAUd4+eGWoHN9EKiuW85AUEMPCTo7SxpAdnPI7eAEU4qJk52s210NU0lUPmxA==
X-Received: by 2002:a17:906:fc4:: with SMTP id c4mr6233854ejk.143.1612563907514;
        Fri, 05 Feb 2021 14:25:07 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:66bb])
        by smtp.gmail.com with ESMTPSA id u5sm4862228edc.29.2021.02.05.14.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:25:07 -0800 (PST)
Date:   Fri, 5 Feb 2021 22:25:06 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH] printk: Userspace format enumeration support
Message-ID: <YB3Fwh827m0F+y3n@chrisdown.name>
References: <YBwU0G+P0vb9wTwm@chrisdown.name>
 <YB11jybvFCb95S9e@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YB11jybvFCb95S9e@alley>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Petr,

Thanks for looking over the patch. :-)

Petr Mladek writes:
>> Most production issues come from unexpected phenomena, and as such
>> usually the code in question doesn't have easily usable tracepoints or
>> other counters available for the specific problem being mitigated. We
>> have a number of lines of monitoring defence against problems in
>> production (host metrics, process metrics, service metrics, etc), and
>> where it's not feasible to reliably monitor at another level, this kind
>> of pragmatic netconsole monitoring is essential.
>>
>> As you'd expect, monitoring using printk is rather brittle for a number
>> of reasons -- most notably that the message might disappear entirely in
>> a new version of the kernel, or that the message may change in some way
>> that the regex or other classification methods start to silently fail.
>
>Another is that printk() is not reliable on its own. Messages might
>get lost. The size of the log buffer is limited. Deamon reading
>/dev/kmsg need not be scheduled in time or often enough. Console
>might be slow. The messages are filtered on the console by console_loglevel.

This is of course true. We don't use kmsg as the last line of defence for 
monitoring or remediation, of course, but it would be unwise to not have 
infrastructure capable of monitoring it. We often need to act quickly when 
production incidents happen, and often kmsg is the place where those 
"unexpected" issues are surfaced. It's often much more likely that there is 
some kmsg log which we can act on in those scenarios than anything else, and 
even if it's not ideal, in reality, it's typically reliable enough to at least 
mitigate the problem when dealing with a large fleet of machines :-)

>>     # Format: <module>,<facility><level><format>\0
>>     $ perl -p -e 's/\n/\\n/g;s/\0/\n/g' /proc/printk_formats | shuf -n 5
>>     vmlinux,6Disabling APIC timer\n
>>     intel_rapl_common,3intel_rapl_common: Cannot find matching power limit for constraint %d\n
>>     dm_crypt,3device-mapper: crypt: %s: INTEGRITY AEAD ERROR, sector %llu\n
>>     mac80211,6%s: AP bug: HT capability missing from AssocResp\n
>>     vmlinux,3zpool: couldn't create zpool - out of memory\n
>
>The facility and log level are not well separated from the format string.
>
>Also this is yet another style how the format is displayed. We already have
>
>	+ console/syslog: formated by record_print_text()
>	+ /dev/kmsg: formatted by info_print_ext_header(),  msg_print_ext_body().
>	+ /sys/kernel/debug/dynamic_debug/control
>	+ /sys/kernel/debug/tracing/printk_formats
>
>We should get some inspiration from the existing interfaces.

Sure, I'm not super bound to the format, as long as we have something that can 
aid those maintaining these systems which monitor printk in identifying that a 
format was mutated or removed. The module is more or less optional -- it's just 
intended as a hint about where to look.

>But we first should decide what information might be useful:
>
>   + 'facility' should not be needed. All messages should be from
>      kernel.

That's fair enough, it can be omitted. I just didn't want to stray too far from 
the netconsole format, since we already mostly have it in this format there.

My intention is to _not_ deviate from existing interfaces, really, so I'll be 
happy with any suggested format that will achieve this patch's stated goals, 
since this kind of data is sorely needed :-)

>   + <module> is already optinaly added by pr_fmt() to the printed strings
>     as:  pr_fmt(): ...

pr_fmts are not consistently used across the kernel, and sometimes differ from 
the module itself. Many modules don't use it at all, and we also don't have it 
for pr_cont. Just picking some random examples:

     % grep -av vmlinux /proc/printk_formats | shuf -n 10
     mac80211,6%s: mesh STA %pM switches to channel requiring DFS (%d MHz, width:%d, CF1/2: %d/%d MHz), aborting
     thinkpad_acpi,c N/Athinkpad_acpi,c %dthinkpad_acpi,5thinkpad_acpi: temperatures (Celsius):thinkpad_acpi,3thinkpad_acpi: Out of memory for LED data
     i915,6drm/i915 developers can then reassign to the right component if it's not a kernel issue.
     video,4[Firmware Bug]: _BCQ is used instead of _BQC
     i915,3gvt: requesting SMI service
     are MMIO SPTEs.
     i915,3gvt: invalid tiling mode: %x
     video,3ACPI: Create sysfs link
     cec,6cec-%s: duplicate logical address type
     soundwire_bus,3%s: %s: inconsistent state state %d

>> +static int proc_pf_show(struct seq_file *s, void *v)
>> +{
>> +	const struct printk_fmt_sec *ps = NULL;
>> +	const char **fptr = NULL;
>> +
>> +	mutex_lock(&printk_fmts_mutex);
>> +
>> +	list_for_each_entry(ps, &printk_fmts_list, list) {
>> +		const char *mod_name = ps_get_module_name(ps);
>> +
>> +		for (fptr = ps->start; fptr < ps->end; fptr++) {
>> +			seq_puts(s, mod_name);
>> +			seq_putc(s, ',');
>> +			seq_puts(s, *fptr);
>> +			seq_putc(s, '\0');
>> +		}
>
>You probably should get inspiration from t_show() in trace_printk.c.
>It handles newlines, ...
>
>Or by ddebug_proc_show(). It uses seq_escape().
>
>Anyway, there is something wrong at the moment. The output looks fine
>with cat. But "less" says that it is a binary format and the output
>is a bit messy:

Hmm, why should that be a problem? It's intentional that this pretty much just 
directly replicates the format string passed to printk, since it's easy to 
write a parser for it:

1. Go up to the comma, take the module
2. Take the facility and level
3. Take the rest up to a \0 as the format
4. Go to 1

I don't mind to have it escaped, but I'm not immediately seeing the benefit. We 
also don't escape `\0` in (for example) `/proc/pid/cmdline`, since it serves as 
a good natural delimiter.

Thanks for taking the time to review :-)

Chris
