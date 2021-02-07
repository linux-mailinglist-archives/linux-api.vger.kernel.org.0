Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83F53125E8
	for <lists+linux-api@lfdr.de>; Sun,  7 Feb 2021 17:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBGQOj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Feb 2021 11:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBGQOj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Feb 2021 11:14:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCD7C061786
        for <linux-api@vger.kernel.org>; Sun,  7 Feb 2021 08:13:58 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m1so10883377wml.2
        for <linux-api@vger.kernel.org>; Sun, 07 Feb 2021 08:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f37oj4SSGjJfGtwkQjnruEKUcZ9jnJkZgRlS8GvfDpk=;
        b=VjnOiaVP9qw4+aXLb3VabaMjxoNmVuHAsR3OCyqZ/I91l4V/FRz78g69nwUOo0QROL
         dlU9D/owyWqjoqI9lAViV916GWcsWhQX7LFOxUeMaPSUYFlfBQMGNMgOzPxoEVhv7wWi
         nU9vOrAQpYnmdwbyKkBh5Vb+Bdo6GUREdio6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f37oj4SSGjJfGtwkQjnruEKUcZ9jnJkZgRlS8GvfDpk=;
        b=PGo2/veZ1GqWwrBBbnoqqeQs1KUT3kNCnIXWP1f4lh+O5iZiITyFglWKwBt8s1ekM6
         UmrHNyhgO4s+bdvTFwOm2Hbu+DIyg42p5VX/hrRIaLs1GQrzK/zOGlcbG4lLCGSt6iN7
         bIM+NKSKXfQiNLnwnDubt75g3RpI6IeXtZIaYyC26nlt2UIxkurPdfyYM3FLjO53Uecs
         Ein5vZa2d2wcdcseteBN7bNE6Zas+ou37i8OeZ6qhI1zRM1xu9YVDy7MSyPIQ2pu8It0
         NggwosvaDc6D2nauWhcm6qHhu2HEYq6BJL59h29UgGdk6hoXOzYxvhT0+OuFxuh+m+Q4
         Inpw==
X-Gm-Message-State: AOAM533+sZ778q4d/nIyh6dMaT9TXUJGtZ/km6BpG3MAzgYlAFP6mH2F
        ufWrXAZT+2gy/0X2u2F6Sb9gKg==
X-Google-Smtp-Source: ABdhPJy/G6UTTnVN7G8hSm4cI5wnEUspUGa1gKabuiqwlIqZPGMWhGgLTEcznMyRnlOAaCxUGYFdbQ==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr11517942wmy.120.1612714436498;
        Sun, 07 Feb 2021 08:13:56 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id u3sm25613442wre.54.2021.02.07.08.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 08:13:55 -0800 (PST)
Date:   Sun, 7 Feb 2021 16:13:55 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <YCARw7dYA7R3Dx3m@chrisdown.name>
References: <YBwU0G+P0vb9wTwm@chrisdown.name>
 <YB11jybvFCb95S9e@alley>
 <YB3Fwh827m0F+y3n@chrisdown.name>
 <49124db60cdc88c4e9fcca1bbc9767432ad5a93b.camel@perches.com>
 <YB8IcCqOJA7vzqiJ@chrisdown.name>
 <dc6cf90d978e012b0d698a698935d526ca4b0a1c.camel@perches.com>
 <YB/1iHwwTi9dOv38@chrisdown.name>
 <bd53d894b7bb0fcaa520282a04a6487828282695.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd53d894b7bb0fcaa520282a04a6487828282695.camel@perches.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Joe Perches writes:
>> There are several issues with your proposed approach that make it unsuitable
>> for use as part of a reliable production environment:
>>
>> 1. It misses printk() formats without KERN_SOH
>>
>> printk() formats without KERN_SOH are legal and use MESSAGE_LOGLEVEL_DEFAULT.
>> On my test kernel, your proposed patch loses >5% of printk formats -- over 200
>> messages -- due to this, including critical ones like those about hardware or
>> other errors.
>
>There are _very_ few of those printks without KERN_<level> and those
>very few are not generally being changed.

I already specified how many are lost: 5%. That's not "very few". That's a huge 
proportion of the coverage afforded by this patch, including several important 
cases.

Relying on "they generally don't change" is not a recipe for reliability or 
success (and they do change, more data on that below).

>> 2. Users don't always have the kernel image available
>>
>> Many of our machines and many of the machines of others like us do not boot
>> using local storage, but instead use PXE or other technologies where the kernel
>> may not be stored during runtime.
>>
>> As is described in the changelog, it is necessary to be able to vary
>> remediations not only based on what is already in /dev/kmsg, but also to be
>> able to make decisions about our methodology based on what's _supported_ in the
>> running kernel at runtime, and your proposed approach makes this not viable.
>
>Indirection would alway work.
>
>You could load a separate file with output strings along with your
>kernel image.

You're moving the goalposts quite quickly here, which makes it harder to reply 
to your points. Now you're proposing an entirely separate distribution path, 
compared to interfaces that we already have precedent for in the kernel (eg.  
trace_printk). That requires a strong justification, and I'm not seeing one 
here.

>> 3. `KERN_SOH + level' can appear in other places than just printk strings
>>
>> KERN_SOH is just ASCII '\001' -- it's not distinctive or unique, even when
>> paired with a check for something that looks like a level after it. For this
>> reason, your proposed patch results in a non-trivial amount of non-printk
>> related garbage in its output. For example:
>>
>>      % binutils/strings -k /tmp/vmlinux | head -5
>>      3L)s
>>      3L)s
>>      c,[]A\
>>      c(L)c
>>      d$pL)d$`u4
>>
>> Fundamentally, one cannot use a tool which just determines whether something is
>> printable to determine semantic intent.
>
>$ kernel_strings --kernel --section ".rodata" vmlinux
>
>I got exactly 0.

"It works on my computer" is not a valid testing methodology, especially for 
something as complex as the Linux kernel. It's especially not a valid rebuttal 
to someone demonstrating that it clearly doesn't work on theirs.

Even filtering to the .rodata section, there's plenty of garbage just in the 
first five cases:

     % binutils/strings --kernel --section ".rodata" /tmp/vmlinux | head -5
     3******* Your BIOS seems to not contain a fix for K8 errata #93
     1>pBC)
     dTRAC
     6Run %s as init process
     7calling  %pS @ %i

Clearly there are cases that you are not considering. My kernel config is 
attached if you want to try and replicate, but regardless, it's really not 
valid to say "it works for me" in response to someone showing that it doesn't.

>> 4. strings(1) output cannot differentiate embedded newlines and new formats
>>
>> The following has exactly the same output from strings(1), but will manifest
>> completely differently at printk() time:
>>
>>      printk(KERN_ERR "line one\nline two\nline three\n");
>>      printk("line four\n");
>
>This is not the preferred output style and is only done in old and
>unchanging code.
>
>Your use case in your commit log is looking for _changed_ formats.

Joe, it's fine to present alternatives to people's patches, but please do your 
research before spouting things like this. It's a waste of everyone's time to 
refute things which are so easily demonstrated to be false.

Here are a bunch of recent changes to printk I found just from literally 2 
minutes of looking through `git log`:

- ea34f78f3df6: 2020, printk site deleted (which of course we also need to know.)
- a0f6d924cada: 2020, new callsite. the level is printed dynamically, so your proposed patch would not match.
- bf13718bc57a: 2020, existing printk changed. 
- 994388f228c6: 2020, printk site changed to au0828_isocdbg, reworded entirely.
- a8b62fd08505: 2020, new callsite, dynamic level.

I could find literally pages and pages of these just from the last few years.  
Your belief that these printks are only in "unchanging" code does not match 
reality.

>On Thu, 2021-02-04 at 15:37 +0000, Chris Down wrote:
>> This patch provides a solution to the issue of silently changed or
>> deleted printks:
>
>Exactly _how_ many of these use cases do you think exist?
>
>The generally preferred style for the example above would be:
>
>	pr_err("line one\n");
>	pr_err("line two\n");
>	pr_err("line three\n");
>	pr_err("line four\n");

I have no idea why you think this is so rare -- we have mixed pr_* and 
unadorned printk() all over the codebase. A number of the patches I just gave 
above are in files with mixed calls.

>> The originally posted patch _does_ differentiate between these cases, using \0
>> as a reliable separator. Its outputs are, respectively:
>>
>>      \0013line one\nline two\nline three\0\nline four\n\0
>>      \0013line one\nline two\n\0line three\nline four\n\0
>>
>> This isn't just a theoretical concern -- there are plenty of places which use
>> multiline printks, and we must be able to distinguish between that and
>> _multiple_ printks.
>
>Just like there are many places that use buffered printks as the
>example I gave earlier.  None of which your proposed solution would find.

There are always going to be cases which are not caught. The point is that the 
patch proposed in this thread captures significantly more cases than the 
`strings` case (not to mention that it avoids outputting garbage from .rodata), 
not that it covers every imaginable scenario.

>> 5. strings(1) is not contextually aware, and cannot be made to act as if it is
>>
>> strings has no idea about what it is reading, which is why it is more than
>> happy to output the kind of meaningless output shown in #3. There are plenty of
>> places across the kernel where there might be a sequence of bytes which the
>> strings utility happens to interpret as being semantically meaningful, but in
>> reality just happens to be an unrelated sequence of coincidentally printable
>> bytes that just happens to contain a \001.
>>
>> I appreciate your willingness to propose other solutions, but for these
>> reasons, the proposed strings(1) patch would not suffice as an interface for
>> printk enumeration.
>
>I think you are on a path to try to make printk output immutable.
>I think that's a _very_ bad path.

That's literally the opposite of what this patchset does. This patchset 
offloads the responsibility of worrying about userspace parsers breaking 
because of changes to kernel printks, because those userspace parsers and 
maintainers now have a mechanism to detect changes. If anything, it _reduces_ 
the risk of what you're describing.
